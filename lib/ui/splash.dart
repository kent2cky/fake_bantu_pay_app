import 'dart:async';
import 'package:fake_bantu_pay/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/asset.dart';
import '../models/transaction_types.dart';
import '../models/user.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _initialized = false;
  AppState? _appState;
  final _storage = LocalStorage('fake_bantu_pay_app.json');
  List<Asset>? _listedAssets;
  User? _currentAccount;
  List<Transaction>? _listedTransactions;
  bool? _biometricsEnabled;

  void init() {
    _biometricsEnabled = _storage.getItem('biometricsEnabled');

    var assets = _storage.getItem('listed_assets');

    if (assets != null) {
      _listedAssets = List<Asset>.from(assets.map((e) {
        Asset result = Asset().deserializeJSON(e);
        return result;
      }));
    }

    var account = _storage.getItem('current_account');
    print('account: $account');
    if (account != null) {
      _currentAccount = User().deserializeJson(account);
    }

    var transactions = _storage.getItem('transactions');
    if (transactions != null) {
      _listedTransactions = List<Transaction>.from(transactions.map((e) {
        Transaction result = Transaction(
                transactionId: '',
                timestamp: DateTime.now(),
                asset: Asset(),
                transactionType: TransactionType.send)
            .deserializeJson(e);
        return result;
      }));
    }

    if (_listedAssets == null || _listedAssets!.isEmpty) {
      _listedAssets = [
        Asset(
          id: 1,
          name: 'XBN',
          fullName: 'Bantu Network Token',
          description:
              'Bantu Network Token is the native asset and network utility token issued by the Bantu Blockchain Foundation',
          issuer: 'www.bantufoundation.org',
          logo: 'images/xbn-logo.png',
          availableBalance: 834.4748608,
          nairaExchangeRate: 17.13164,
          nairaValue: 0.0,
        ),
        Asset(
          id: 2,
          name: 'BNR',
          fullName: 'BNR',
          description: 'Bantu Network Token',
          issuer: 'www.bantufoundation.org',
          logo: 'images/bnr-logo.png',
          availableBalance: 320.8382881,
          nairaExchangeRate: 2.1422,
          nairaValue: 0.0,
        ),
      ];
    }

    if (_listedTransactions == null || _listedTransactions!.isEmpty) {
      _listedTransactions = [
        Transaction(
          transactionId:
              'VBNIR4304DFD094DFLKFDLKDLFKDLFFDLDFDL9534DFKLLFLDFKDFDLDLKF',
          timestamp: DateTime(2022, 03, 14, 18, 59),
          asset: Asset(name: 'XBN', transferQnty: 700.000),
          transactionType: TransactionType.receive,
          sender: User(
              walletAddress: 'LKJZXE23SDD34332SSX4SZ323244',
              username: 'rikkan',
              firstName: 'Emeka',
              lastName: 'Okeke'),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context);

    return FutureBuilder(
        future: _storage.ready,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            init();
            if (!_initialized) {
              _initialized = true;
              persistData();
              Timer(const Duration(seconds: 5), () {
                _appState?.listedAssets = _listedAssets;
                _appState?.currentAccount = _currentAccount;
                _appState?.transactions = _listedTransactions;
                _appState?.biometricEnabled = _biometricsEnabled ?? false;
                _appState?.setSplashFinished();
              });
            }
          }
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    "images/loadscreen.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        });
  }

  void persistData() async {
    var listedAssetString =
        _listedAssets?.map((asset) => asset.toJSONEncodable()).toList();
    await _storage.setItem('listed_assets', listedAssetString);

    if (_currentAccount != null) {
      var accountString = _currentAccount?.toJSONEncodable();
      await _storage.setItem('current_account', accountString);
    }

    var transString = _listedTransactions
        ?.map((transaction) => transaction.toJSONEncodable())
        .toList();

    await _storage.setItem('transactions', transString!);
  }
}
