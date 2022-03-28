import 'package:fake_bantu_pay/models/transaction_types.dart';

import 'asset.dart';
import 'user.dart';

class Transaction {
  String transactionId;
  DateTime timestamp;
  String? memo;
  Asset asset;
  Asset? destinationAsset; // if its a swap transaction
  TransactionType transactionType;
  User? reciever;
  User? sender;
  Transaction({
    required this.transactionId,
    required this.timestamp,
    required this.asset,
    this.destinationAsset,
    required this.transactionType,
    this.reciever,
    this.sender,
    this.memo,
  });
}
