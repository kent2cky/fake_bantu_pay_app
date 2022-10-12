import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';
import '../app_state.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../models/transaction.dart';
import '../models/transaction_types.dart';
import '../models/user.dart';
import '../router/ui_pages.dart';
import '../utility.dart';

class MyQRView extends StatefulWidget {
  const MyQRView({Key? key}) : super(key: key);

  @override
  _MyQRViewState createState() => _MyQRViewState();
}

bool expanded = false;

class _MyQRViewState extends State<MyQRView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  AppState? appState;
  bool? flashLightStatus;
  final Utility _utility = Utility();
  bool isLoading = false;

  Future<String?>? scanResult;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  Future<void> reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      appState = Provider.of<AppState>(context, listen: false);
    });
    return FutureBuilder(
      future: scanResult,
      builder: ((context, AsyncSnapshot<String?> snapshot) {
        return _buildScanner(snapshot);
      }),
    );
  }

  Widget _buildScanner(AsyncSnapshot<String?> snapshot) {
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          QRView(
            cameraFacing: CameraFacing.back,
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              overlayColor: const Color.fromARGB(69, 0, 0, 0),
              borderRadius: 10,
              borderWidth: 5,
              borderColor: Colors.white,
              cutOutSize: MediaQuery.of(context).size.width - 45,
              cutOutBottomOffset: 60,
            ),
          ),
          AppBar(
            iconTheme: IconThemeData(
              color: Colors.grey.shade800, //change your color here
            ),
            backgroundColor: Colors.transparent.withOpacity(0.0),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.width - 20,
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  // color: Colors.red,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                      onPressed: _toggleFlashlight,
                      icon: Icon(
                        _getIcon(),
                        color: Colors.white60,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    'Please place the BantuPay QRcode inside the frame',
                    style: _utility.getTextStyle(
                        color: Colors.white60, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                height: 74,
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                ),
              ),
            ],
          ),
          Center(child: loader()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            snapshot.connectionState == ConnectionState.none ? decode : null,
        tooltip: 'QR Code Scanner',
        child: const Icon(
          Icons.image_outlined,
          size: 35.0,
        ),
        backgroundColor: Colors.transparent.withOpacity(0.0).withOpacity(0.0),
        elevation: 0,
      ),
    );
  }

  Widget loader() {
    if (isLoading) {
      return LoadingOverlay(
        isLoading: true,
        opacity: 0.1,
        child: Container(
          alignment: FractionalOffset.center,
          child: const CircularProgressIndicator(
            backgroundColor: Colors.green,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      _handleScanResult(scanData.code);
    });
  }

  void _toggleFlashlight() async {
    await controller?.toggleFlash();
    flashLightStatus = await controller?.getFlashStatus();
    // run setState to update state after all the awaitables finish running
    setState(() {});
  }

  IconData _getIcon() {
    if (flashLightStatus == null) {
      return Icons.flashlight_on_rounded;
    } else {
      return flashLightStatus!
          ? Icons.flashlight_off_rounded
          : Icons.flashlight_on_rounded;
    }
  }

  /// decode from local file
  Future<void> decode() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        isLoading = true;
      });
      Scan.parse(image.path).then((scanResult) {
        _handleScanResult(scanResult);
      });
    }
  }

  void _handleScanResult(String? scanResult) {
    appState?.currentAssetId = 1;
    appState?.transactionDetail = Transaction(
      transactionId: DateTime.now().toString(),
      timestamp: DateTime.now(),
      asset: appState!.listedAssets!
          .firstWhere((asset) => asset.id == appState!.currentAssetId),
      reciever: User(username: '', walletAddress: ''),
      transactionType: TransactionType.send,
      memo: scanResult,
    );

    appState?.currentAction =
        PageAction(state: PageState.replace, page: ScanResultPageConfig);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
