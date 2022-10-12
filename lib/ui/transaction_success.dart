import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../local_auth.dart';
import '../models/transaction.dart';
import '../models/transaction_types.dart';
import '../router/ui_pages.dart';
import '../utility.dart';

class TransactionSuccessPage extends StatefulWidget {
  const TransactionSuccessPage({Key? key}) : super(key: key);

  @override
  _TransactionSuccessPageState createState() => _TransactionSuccessPageState();
}

class _TransactionSuccessPageState extends State<TransactionSuccessPage> {
  final Utility _utility = Utility();
  bool isAuthenticated = false;
  final Authenticator _authenticator = Authenticator();
  final iconOk = 'images/icon-ok.svg';
  final avatarImage =
      'https://pps.whatsapp.net/v/t61.24694-24/172187436_541505470458673_3253590271101490585_n.jpg?ccb=11-4&oh=01_AVzrN_wez8D19DFwJ7KgOge9ZiMorKHti1TJNVvYdAEpIw&oe=6230A14A';

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white60,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 270,
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: SvgPicture.asset(iconOk,
                            semanticsLabel: 'Acme Logo'),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        height: 220,
                        // color: Colors.red,
                      ),
                      const Text(
                        'Transaction Successful',
                        style: TextStyle(
                          fontSize: 23.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 12.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '- ${appState.transactionDetail?.asset.transferQnty?.toStringAsFixed(7)}',
                                style: _utility.getTextStyle(
                                    color: Colors.red,
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: appState.transactionDetail?.asset.name,
                                style: _utility.getTextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red,
                                    fontSize: 23.0),
                              ),
                            ],
                          ),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Sent to: ',
                                    style:
                                        _utility.getTextStyle(fontSize: 12.0),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            foregroundImage: AssetImage(
                                                'images/default-user.png'),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: _getUserAddress(
                                                        appState
                                                            .transactionDetail!),
                                                    style:
                                                        _utility.getTextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              _getUserFullName(
                                                  appState.transactionDetail!),
                                              style: _utility.getTextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () => {
                                        Clipboard.setData(
                                          ClipboardData(
                                            text: _getUserAddress(
                                              appState.transactionDetail!,
                                            ),
                                          ),
                                        ),
                                        _utility.showSnackBar(
                                            'Username', context),
                                      },
                                      icon: const Icon(Icons.copy_rounded),
                                      iconSize: 18,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 0.2,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                                  child: Text(
                                    'Transaction ID: ',
                                    style:
                                        _utility.getTextStyle(fontSize: 12.0),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _getTransactionId(
                                          appState.transactionDetail!),
                                      style: _utility.getTextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    IconButton(
                                      onPressed: () => {
                                        Clipboard.setData(
                                          ClipboardData(
                                            text: appState.transactionDetail
                                                ?.transactionId
                                                .toLowerCase(),
                                          ),
                                        ),
                                        _utility.showSnackBar(
                                            'Transaction ID', context),
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
                      ElevatedButton(
                        onPressed: () async {
                          appState.transactionDetail = null;
                          appState.currentAction = PageAction(
                              state: PageState.replaceAll,
                              page: DashboardPageConfig);
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(300.0, 33.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          'Dashboard',
                          style: _utility.getTextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getUserAddress(Transaction transaction) {
    switch (transaction.transactionType) {
      case TransactionType.receive:
        return truncate(transaction.sender?.username ?? '',
            length: 8, omission: '...');
      case TransactionType.swap:
        return '';
      default:
        return truncate(transaction.reciever?.username ?? '',
            length: 8, omission: '...');
    }
  }

  String _getUserFullName(Transaction transaction) {
    switch (transaction.transactionType) {
      case TransactionType.receive:
        return '${transaction.sender?.firstName ?? 'John'} ${transaction.sender?.lastName ?? 'Doe'}';
      case TransactionType.swap:
        return '';
      default:
        return '${transaction.sender?.firstName ?? 'John'} ${transaction.sender?.lastName ?? 'Doe'}';
    }
  }

  String _getTransactionId(Transaction transaction) {
    print('transactionId: ${transaction.transactionId}');
    if (transaction.transactionId.length <= 8) {
      return transaction.transactionId.toLowerCase();
    } else {
      return '${truncate(transaction.transactionId, length: 8, omission: '...')}.${transaction.transactionId.substring(transaction.transactionId.length - 8, transaction.transactionId.length)}'
          .toLowerCase();
    }
  }

  String truncate(String text, {length: 7, omission: '...'}) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, omission);
  }
}
