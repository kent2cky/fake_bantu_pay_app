import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import '../app_state.dart';
import '../models/transaction.dart';
import '../utility.dart';

class RequestSpecificAmountConfirm extends StatefulWidget {
  const RequestSpecificAmountConfirm({Key? key}) : super(key: key);

  @override
  _RequestSpecificAmountConfirmState createState() =>
      _RequestSpecificAmountConfirmState();
}

class _RequestSpecificAmountConfirmState
    extends State<RequestSpecificAmountConfirm> {
  final Utility _utility = Utility();
  bool isAuthenticated = false;
  final numberFormatter = NumberFormat("#,##0.0000", "en_US");
  final avatarImage = 'images/default-user.png';
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    final transaction = appState.transactionDetail;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey.shade800, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.grey.shade300,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  Container(
                    height: 20.0,
                  ),
                  Text(
                    'You are requesting: ',
                    style: _utility.getTextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Container(
                      height: 70,
                      width: 310,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: transaction?.asset.transferQnty
                                        ?.toStringAsFixed(7),
                                    style: _utility.getTextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: transaction?.asset.name,
                                    style: _utility.getTextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        fontSize: 13.0),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '≈ ${numberFormatter.format(transaction?.asset.nairaValue ?? 0)} NGN',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (transaction!.memo != null &&
                      transaction.memo!.isNotEmpty) ...[
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'For: ',
                      style: _utility.getTextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Container(
                        width: 310,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                transaction.memo ?? '',
                                style: _utility.getTextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 30),
                          child: Text(
                            'Scan QR',
                            style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: "Source Sans Pro",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  RepaintBoundary(
                    key: qrKey,
                    child: Container(
                      color: Colors.white,
                      child: QrImage(
                        data:
                            "I am requesting that you pay me ${transaction.asset.transferQnty} ${transaction.asset.name}. https://bantupayapp.page.link/w2F2",
                        version: QrVersions.auto,
                        size: 300.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                _share(appState.transactionDetail!),
                            child: Text(
                              'Share',
                              style: _utility.getTextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                const Size(177, 65),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () => {
                              appState.currentAction = PageAction(
                                  state: PageState.replaceAll,
                                  page: DashboardPageConfig),
                            },
                            child: Text(
                              'Done',
                              style: _utility.getTextStyle(
                                fontWeight: FontWeight.w300,
                                color: const Color(0xFFEF6C00),
                              ),
                            ),
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                const Size(177, 65),
                              ),
                              side: MaterialStateProperty.all(
                                const BorderSide(
                                    color: Color(0xFFEF6C00),
                                    width: 1,
                                    style: BorderStyle.solid),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _share(Transaction transaction) async {
    final boundary =
        qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // We can increse the size of QR using pixel ratio
    final image = await boundary.toImage(pixelRatio: 5.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.png').create();
    await file.writeAsBytes(pngBytes);
    Share.shareFiles(['${tempDir.path}/image.png'],
        text:
            "Payment request of ${transaction.asset.transferQnty} ${transaction.asset.name} from kent2cky \n\nhttps://bantupayapp.page.link/w2F2");
  }
}
