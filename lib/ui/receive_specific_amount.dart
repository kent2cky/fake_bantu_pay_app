import 'package:fake_bantu_pay/models/transaction.dart';
import 'package:fake_bantu_pay/models/transaction_types.dart';
import 'package:fake_bantu_pay/models/user.dart';
import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../utility.dart';

class ReceiveSpecificAmount extends StatefulWidget {
  const ReceiveSpecificAmount({Key? key}) : super(key: key);

  @override
  _ReceiveSpecificAmountState createState() => _ReceiveSpecificAmountState();
}

class _ReceiveSpecificAmountState extends State<ReceiveSpecificAmount> {
  final Utility _utility = Utility();
  final _amountTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _memoTextController = TextEditingController();
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
      asset: _appState!.listedAssets
          .firstWhere((asset) => asset.id == _appState!.currentAssetId),
      reciever: User(username: '', walletAddress: ''),
      transactionType: TransactionType.send,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // here the desired height
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
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 30),
                            child: Text(
                              'Request ${_transaction?.asset.name}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontFamily: "Source Sans Pro",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                horizontal: 20.0, vertical: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                        enabledBorder:
                                            _utility.getEnabledBorderColor(),
                                        alignLabelWithHint: true,
                                        labelText: 'Amount',
                                        labelStyle: _utility.getTextStyle(
                                            fontSize: 17.0),
                                        hintText: '0',
                                        hintStyle: _utility.getTextStyle(
                                            fontSize: 11.0),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
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
                                    labelStyle:
                                        _utility.getTextStyle(fontSize: 17.0),
                                    hintText: 'Description',
                                    hintStyle:
                                        _utility.getTextStyle(fontSize: 11.0),
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
                      height: 60.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        _appState?.transactionDetail = _transaction;

                        _appState?.currentAction = PageAction(
                          state: PageState.addPage,
                          page: RequestSpecificAmountConfirmPageConfig,
                        );
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
