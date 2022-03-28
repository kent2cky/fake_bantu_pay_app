import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/transaction.dart';
import '../models/transaction_types.dart';
import '../router/ui_pages.dart';
import '../utility.dart';
import 'package:timeago/timeago.dart' as timeago;

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);
  final Utility _utility = Utility();
  AppState? appState;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey.shade200,
            child: Column(
              children: [
                Container(
                  height: 93.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          'History',
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
                for (var transaction in appState!.transactions) ...[
                  _myTile(
                    transaction: transaction,
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _myTile({
    required Transaction transaction,
  }) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
          child: Container(
            width: 310,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: _getIcon(transaction.transactionType),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              timeago.format(transaction.timestamp),
                              style: _utility.getTextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  if (transaction.transactionType !=
                                      TransactionType.swap) ...[
                                    TextSpan(
                                        text: transaction.transactionType ==
                                                TransactionType.send
                                            ? '- '
                                            : '+ ',
                                        style: _utility.getTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.0,
                                        )),
                                  ],
                                  TextSpan(
                                      text: transaction.transactionType ==
                                              TransactionType.swap
                                          ? '${_getSwapValue(transaction)} '
                                          : '${transaction.asset.transferQnty?.toStringAsFixed(0)} ',
                                      style: _utility.getTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                      )),
                                  TextSpan(
                                      text: transaction.transactionType ==
                                              TransactionType.swap
                                          ? transaction.destinationAsset!.name!
                                          : transaction.asset.name,
                                      style: _utility.getTextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.0,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: _getRel(transaction),
                                  style: _utility.getTextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12.0,
                                  )),
                              TextSpan(
                                  text: _getUserAddress(transaction),
                                  style: _utility.getTextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () => {
              appState!.transactionDetail = transaction,
              appState?.currentAction = PageAction(
                  state: PageState.addPage, page: TransactionDetailPageConfig),
            });
  }

  String _getRel(Transaction transaction) {
    switch (transaction.transactionType) {
      case TransactionType.receive:
        return 'Received from ';
      case TransactionType.swap:
        return 'Swapped from ${transaction.asset.name} to ${transaction.destinationAsset!.name!}';
      default:
        return 'Sent to ';
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

  Widget _getIcon(TransactionType? transactionType) {
    switch (transactionType) {
      case TransactionType.receive:
        return const Icon(
          Icons.south_east,
          color: Colors.green,
        );
      case TransactionType.swap:
        return Icon(
          Icons.swap_vertical_circle_outlined,
          color: Colors.grey[600],
        );
      default:
        return const Icon(
          Icons.north_east,
          color: Colors.red,
        );
    }
  }

  String _getSwapValue(Transaction transaction) {
    transaction.asset.nairaValue =
        transaction.asset.transferQnty! * transaction.asset.nairaExchangeRate!;
    return (transaction.asset.nairaValue! /
            transaction.destinationAsset!.nairaExchangeRate!)
        .toStringAsFixed(0);
  }

  String truncate(String text, {length: 7, omission: '...'}) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, omission);
  }
}
