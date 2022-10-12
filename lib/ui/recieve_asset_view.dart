import 'package:fake_bantu_pay/models/transaction.dart';
import 'package:fake_bantu_pay/models/transaction_types.dart';
import 'package:fake_bantu_pay/models/user.dart';
import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../app_state.dart';
import '../utility.dart';

class RecieveAsset extends StatefulWidget {
  const RecieveAsset({Key? key}) : super(key: key);

  @override
  _RecieveAssetState createState() => _RecieveAssetState();
}

class _RecieveAssetState extends State<RecieveAsset> {
  final Utility _utility = Utility();
  final numberFormatter = NumberFormat("#,##0.0000", "en_US");
  final _formKey = GlobalKey<FormState>();
  Transaction? _transaction;
  AppState? _appState;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    _transaction = Transaction(
      transactionId: DateTime.now().toString(),
      timestamp: DateTime.now(),
      asset: _appState!.listedAssets!
          .firstWhere((asset) => asset.id == _appState!.currentAssetId),
      reciever: User(username: '', walletAddress: ''),
      transactionType: TransactionType.send,
    );
  }

  @override
  Widget build(BuildContext context) {
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 30),
                          child: Text(
                            'Recieve ${_transaction?.asset.name}',
                            style: const TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Container(
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
                            horizontal: 10.0, vertical: 10.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Receive within BantuPay Wallet',
                                  style: _utility.getTextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'kent2cky',
                                  style: _utility.getTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                    color: Colors.orange[800],
                                  ),
                                ),
                                IconButton(
                                  color: Colors.orange[800],
                                  onPressed: () => {
                                    Clipboard.setData(
                                      const ClipboardData(text: 'kent2cky'),
                                    ),
                                    _showSnackBar('Username', context),
                                  },
                                  icon: const Icon(Icons.copy_rounded),
                                  iconSize: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Container(
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
                            horizontal: 10.0, vertical: 10.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Receive from non BantuPay Wallet',
                                  style: _utility.getTextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  color: Colors.grey.shade300,
                                  width: 266,
                                  child: Center(
                                    child: Text(
                                      'GAVLU3R6M3...HJRDORNFKR',
                                      style: _utility.getTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.orange[800],
                                  onPressed: () => {
                                    Clipboard.setData(
                                      const ClipboardData(
                                        text:
                                            "GAVLU3R6M3DSFS4SDS3ZCESDSDDSSDSDSC56JKKJ9KXZDSDHJRDORNFKR",
                                      ),
                                    ),
                                    _showSnackBar('public key', context),
                                  },
                                  icon: const Icon(Icons.copy_rounded),
                                  iconSize: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 50.0,
                    child: Center(
                      child: Image.asset(
                        'images/icon-below.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
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
                  Container(
                    color: Colors.white,
                    child: QrImage(
                      data: "https://bantupayapp.page.link/w2F2",
                      version: QrVersions.auto,
                      size: 300.0,
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => {
                                _appState?.currentAction = PageAction(
                                    state: PageState.addPage,
                                    page: ReceiveSpecificAmountPageConfig),
                              },
                              child: Text(
                                'Request specific XBN amount',
                                style: _utility.getTextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                  const Size(350, 70),
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
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String rel, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange[800],
        content: Text('$rel copied successfully'),
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: Colors.white,
          onPressed: () => {
            ScaffoldMessenger.of(context).clearSnackBars(),
          },
        ),
      ),
    );
  }
}
