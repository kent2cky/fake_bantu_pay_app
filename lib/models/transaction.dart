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

  toJSONEncodable() {
    Map<String, dynamic> m = Map();

    m['transactionId'] = transactionId;
    m['timestamp'] = timestamp.toIso8601String();
    m['asset'] = asset.toJSONEncodable();
    m['destinationAsset'] = destinationAsset?.toJSONEncodable();
    m['transactionType'] = transactionType.toString();
    m['reciever'] = reciever?.toJSONEncodable();
    m['sender'] = sender?.toJSONEncodable();
    m['memo'] = memo;

    return m;
  }

  deserializeJson(Map<String, dynamic> m) {
    return Transaction(
      transactionId: m['transactionId'],
      timestamp: DateTime.tryParse(m['timestamp'])!,
      asset: Asset().deserializeJSON(m['asset']),
      destinationAsset: m['destinationAsset'] != null
          ? Asset().deserializeJSON(m['destinationAsset'])
          : m['destinationAsset'],
      transactionType: TransactionType.values
          .firstWhere((type) => type.toString() == m['transactionType']),
      reciever: m['reciever'] != null
          ? User().deserializeJson(m['reciever'])
          : m['reciever'],
      sender: m['sender'] != null
          ? User().deserializeJson(m['sender'])
          : m['sender'],
      memo: m['memo'],
    );
  }
}
