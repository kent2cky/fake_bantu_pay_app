import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/transaction.dart';
import '../models/transaction_types.dart';
import '../utility.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class TransactionDetail extends StatelessWidget {
  TransactionDetail({Key? key}) : super(key: key);
  final Utility _utility = Utility();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey.shade800, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white60,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white60,
            child: Column(
              children: [
                Container(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          'Transaction Details',
                          style: TextStyle(
                            fontSize: 20.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: "Source Sans Pro",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 55.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child:
                            _getTransactionAsset(appState.transactionDetail!),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 55.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _getTimestampString(
                            appState.transactionDetail?.timestamp),
                        style: _utility.getTextStyle(fontSize: 10.5),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              _getRel(appState.transactionDetail!),
                              style: _utility.getTextStyle(fontSize: 12.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (appState.transactionDetail?.transactionType !=
                                  TransactionType.swap) ...[
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.orange[800],
                                        // foregroundImage: Icon,
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
                                                text: _getUserAddress(appState
                                                    .transactionDetail!),
                                                style: _utility.getTextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                    _showSnackBar('Username', context),
                                  },
                                  icon: const Icon(Icons.copy_rounded),
                                  iconSize: 18,
                                ),
                              ] else ...[
                                Text(
                                  _getSwapDetails(appState.transactionDetail!),
                                  style: _utility.getTextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 0.2,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                            child: Text(
                              'Transaction ID: ',
                              style: _utility.getTextStyle(fontSize: 12.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _getTransactionId(appState.transactionDetail!),
                                style: _utility.getTextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                onPressed: () => {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: appState
                                          .transactionDetail?.transactionId
                                          .toLowerCase(),
                                    ),
                                  ),
                                  _showSnackBar('Transaction ID', context),
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
                Container(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _share(appState.transactionDetail!),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300.0, 33.0),
                    primary: Colors.orange[800],
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Share',
                    style: _utility.getTextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTimestampString(DateTime? timestamp) {
    DateFormat formatter = DateFormat('MMMM dd, yyyy h:mm a');
    String dateString = formatter.format(timestamp!);
    return '$dateString ';
  }

  String _getRel(Transaction transaction) {
    switch (transaction.transactionType) {
      case TransactionType.receive:
        return 'Received from: ';
      case TransactionType.swap:
        return 'For:';
      default:
        return 'Sent to: ';
    }
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
        return '${transaction.sender?.firstName} ${transaction.sender?.lastName}';
      case TransactionType.swap:
        return '';
      default:
        return '${transaction.reciever?.firstName} ${transaction.reciever?.lastName}';
    }
  }

  String _getTransactionId(Transaction transaction) {
    if (transaction.transactionId.length <= 8) {
      return transaction.transactionId.toLowerCase();
    } else {
      return '${truncate(transaction.transactionId, length: 8, omission: '...')}.${transaction.transactionId.substring(transaction.transactionId.length - 8, transaction.transactionId.length)}'
          .toLowerCase();
    }
  }

  String _getSwapDetails(Transaction transaction) {
    return 'swap from ${transaction.asset.name} to ${transaction.destinationAsset?.name}';
  }

  String _getSwapValue(Transaction transaction, {int truncateLength = 0}) {
    transaction.asset.nairaValue =
        transaction.asset.transferQnty! * transaction.asset.nairaExchangeRate!;
    return (transaction.asset.nairaValue! /
            transaction.destinationAsset!.nairaExchangeRate!)
        .toStringAsFixed(truncateLength);
  }

  Widget _getTransactionAsset(Transaction transaction) {
    switch (transaction.transactionType) {
      case TransactionType.swap:
        return Text(
          '${_getSwapValue(transaction)} ${transaction.destinationAsset?.name}',
          style: _utility.getTextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.green),
        );
      case TransactionType.send:
        return Text(
          '- ${transaction.asset.transferQnty} ${transaction.asset.name}',
          style: _utility.getTextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.red),
        );
      default:
        return Text(
          '+ ${transaction.asset.transferQnty} ${transaction.asset.name}',
          style: _utility.getTextStyle(
              fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.green),
        );
    }
  }

  String truncate(String text, {length: 7, omission: '...'}) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, omission);
  }

  void _share(Transaction transaction) {
    String? shareString;
    switch (transaction.transactionType) {
      case TransactionType.swap:
        shareString =
            'Swapped from ${transaction.asset.name} to ${transaction.destinationAsset?.name} \nAmount: ${_getSwapValue(transaction, truncateLength: 7)} \nTransaction Id: ${transaction.transactionId.toLowerCase()} \nTime: ${_getTimestampString(transaction.timestamp)}';
        break;
      case TransactionType.send:
        shareString =
            'Sent ${transaction.asset.transferQnty} to ${transaction.reciever?.username} \nFor: \nTransaction Id: ${transaction.transactionId.toLowerCase()} \nTime: ${_getTimestampString(transaction.timestamp)}';
        break;
      default:
        shareString =
            'Recieved ${transaction.asset.transferQnty} from ${transaction.sender?.username} \nFor: \nTransaction Id: ${transaction.transactionId.toLowerCase()} \nTime: ${_getTimestampString(transaction.timestamp)}';
    }

    Share.share(shareString);
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
