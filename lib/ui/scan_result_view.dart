import 'package:fake_bantu_pay/models/transaction.dart';
import 'package:fake_bantu_pay/models/transaction_types.dart';
import 'package:fake_bantu_pay/models/user.dart';
import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../utility.dart';

class ScanResultPage extends StatefulWidget {
  const ScanResultPage({Key? key}) : super(key: key);

  @override
  _ScanResultPageState createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  final Utility _utility = Utility();
  final _amountTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _memoTextController = TextEditingController();
  final numberFormatter = NumberFormat("#,##0.0000", "en_US");
  final _formKey = GlobalKey<FormState>();
  Transaction? _transaction;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('initing state ooo');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: ((context, appState, child) {
        if (appState.transactionDetail == null) {
          print('appstate.transactiondetails is null oooo');
          _transaction = Transaction(
            transactionId: DateTime.now().toString(),
            timestamp: DateTime.now(),
            asset: appState.listedAssets
                .firstWhere((asset) => asset.id == appState.currentAssetId),
            reciever: User(username: '', walletAddress: ''),
            transactionType: TransactionType.send,
          );
        } else {
          print('this is init state o');
          _transaction = appState.transactionDetail;
          _memoTextController.text = _transaction!.memo ?? '';
        }
        return Scaffold(
          appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(70.0), // here the desired height
            child: AppBar(
              iconTheme: IconThemeData(
                color: Colors.grey.shade800, //change your color here
              ),
              elevation: 0,
              backgroundColor: Colors.white60,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    color: Colors.white60,
                    child: Column(
                      children: [
                        Container(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 20.0),
                                child: Text(
                                  'Send ${_transaction?.asset.name}',
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
                            IconButton(
                              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                              onPressed: () => {
                                appState.currentAction = PageAction(
                                    state: PageState.addPage,
                                    page: MyQRViewPageConfig)
                              },
                              tooltip: 'QR Code Scanner',
                              icon: const Icon(
                                Icons.qr_code_scanner,
                                size: 22.0,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                              height: 270,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
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
                                    horizontal: 20.0, vertical: 20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextFormField(
                                      controller: _usernameTextController,
                                      onChanged: _handleUsernameChanged,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter reviever\'s username or public key';
                                        }

                                        return null;
                                      },
                                      autofocus: true,
                                      style: _utility.getTextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        alignLabelWithHint: true,
                                        labelText: 'To',
                                        enabledBorder:
                                            _utility.getEnabledBorderColor(),
                                        labelStyle: _utility.getTextStyle(),
                                        hintText:
                                            'Enter reciever\'s username or public key',
                                        hintStyle: _utility.getTextStyle(
                                            fontSize: 11.0),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        TextFormField(
                                          style: _utility.getTextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          validator: (value) {
                                            var parsedValue =
                                                double.tryParse(value!);
                                            if (parsedValue == null ||
                                                parsedValue <= 0) {
                                              return 'Enter valid amount to send';
                                            }
                                            return null;
                                          },
                                          controller: _amountTextController,
                                          onChanged: _onTextChanged,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            enabledBorder: _utility
                                                .getEnabledBorderColor(),
                                            alignLabelWithHint: true,
                                            labelText: 'Amount',
                                            labelStyle: _utility.getTextStyle(),
                                            hintText: '0',
                                            hintStyle: _utility.getTextStyle(
                                                fontSize: 11.0),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 3.0, 0.0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '≈ ${numberFormatter.format(_transaction?.asset.nairaValue ?? 0)} NGN',
                                                style: _utility.getTextStyle(
                                                    fontSize: 11.0),
                                              ),
                                              Text(
                                                '${_transaction?.asset.availableBalance} ${_transaction?.asset.name}',
                                                style: _utility.getTextStyle(
                                                    fontSize: 11.0),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      controller: _memoTextController,
                                      onChanged: _handleForChanged,
                                      autofocus: true,
                                      style: _utility.getTextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        alignLabelWithHint: true,
                                        labelText: 'Add Memo (optional)',
                                        enabledBorder:
                                            _utility.getEnabledBorderColor(),
                                        labelStyle: _utility.getTextStyle(),
                                        hintText: 'Description',
                                        hintStyle: _utility.getTextStyle(
                                            fontSize: 11.0),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            if (_transaction!.asset.transferQnty! >
                                (_transaction!.asset.availableBalance! - 6)) {
                              AlertDialog alert = AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: const EdgeInsets.all(20),
                                  content: Center(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(23),
                                        ),
                                      ),
                                      height: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Center(
                                              child: Text(
                                                'Oops!',
                                                style: _utility.getTextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 5.0),
                                            child: Text(
                                              'You must maintain a min balance of 6 ${_transaction!.asset.name}',
                                              style: _utility.getTextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.red,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(), // dismiss dialog,
                                              style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    const Size(300.0, 33.0),
                                                primary: Colors.orange[800],
                                                shape: const StadiumBorder(),
                                              ),
                                              child: Text(
                                                'Continue',
                                                style: _utility.getTextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return alert;
                                  });
                            } else {
                              appState.transactionDetail = _transaction;

                              appState.currentAction = PageAction(
                                state: PageState.addPage,
                                page: ConfirmTransactionPageConfig,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300.0, 33.0),
                            primary: Colors.orange[800],
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                            'Continue',
                            style: _utility.getTextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _onTextChanged(String value) {
    if (_transaction?.asset != null) {
      setState(() {
        _transaction?.asset.transferQnty = double.tryParse(value) ?? 0.0;
        _amountTextController.selection = TextSelection.fromPosition(
            TextPosition(offset: _amountTextController.text.length));
      });
      _calculateExchangeRate(value);
    }
  }

  _handleForChanged(value) {
    _transaction!.memo = value;
    _memoTextController.text = value;
    _memoTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: _memoTextController.text.length));
  }

  _handleUsernameChanged(value) {
    _transaction!.reciever!.username = value;
    _usernameTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: _usernameTextController.text.length));
  }

  _calculateExchangeRate(_) {
    setState(() {
      if (_transaction != null && _transaction?.asset.transferQnty != null) {
        _transaction?.asset.nairaValue = (_transaction!.asset.transferQnty! *
            _transaction!.asset.nairaExchangeRate!);
      }
    });
  }
}
