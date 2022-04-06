import 'package:fake_bantu_pay/models/transaction.dart';
import 'package:fake_bantu_pay/qr_scanner/expected_results.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'models/asset.dart';
import 'models/transaction_types.dart';
import 'models/user.dart';
import 'router/ui_pages.dart';
import 'ui/swap.dart';

const String LoggedInKey = 'LoggedIn';

enum PageState { none, addPage, addAll, addWidget, pop, replace, replaceAll }

class PageAction {
  PageState state;
  PageConfiguration? page;
  List<PageConfiguration>? pages;
  Widget? widget;

  PageAction({
    this.state = PageState.none,
    this.page = null,
    this.pages = null,
    this.widget = null,
  });
}

class AppState extends ChangeNotifier {
  bool hasAgreed = false;
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  bool _splashFinished = false;
  bool get splashFinished => _splashFinished;
  final cartItems = [];
  String? emailAddress;
  String? password;

  List<Asset> listedAssets = [
    Asset(
      id: 1,
      name: 'XBN',
      fullName: 'Bantu Network Token',
      description:
          'Bantu Network Token is the native asset and network utility token issued by the Bantu Blockchain Foundation',
      issuer: 'www.bantufoundation.org',
      logo: 'images/xbn-logo.png',
      availableBalance: 134.4748608,
      nairaExchangeRate: 17.13164,
    ),
    Asset(
      id: 2,
      name: 'BNR',
      fullName: 'BNR',
      description: 'Bantu Network Token',
      issuer: 'www.bantufoundation.org',
      logo: 'images/bnr-logo.png',
      availableBalance: 30.8382881,
      nairaExchangeRate: 2.1422,
    ),
  ];

  final List<Transaction> transactions = [
    Transaction(
      transactionId: 'PPOIML23SDD34332SSX4SZ323244PPOIML23SDD34332SSX4SZ323244',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      asset: Asset(name: 'XBN', transferQnty: 806.000),
      transactionType: TransactionType.send,
      reciever: User(
          walletAddress: 'SDME23SDD34332SSX4SZ323244',
          username: 'slawomir',
          firstName: 'Sly',
          lastName: 'Davids'),
    ),
    Transaction(
      transactionId: 'SALFJSDF334934AKDADS494304SKFDLKFDSKLDKSDKSLDK39302LS9SD',
      timestamp: DateTime(2022, 03, 15, 15, 44),
      asset: Asset(
        name: 'XBN',
        transferQnty: 398.000,
        nairaExchangeRate: 17.13164,
      ),
      transactionType: TransactionType.swap,
      destinationAsset: Asset(
        name: 'BNR',
        nairaExchangeRate: 2.1422,
      ),
    ),
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
    Transaction(
      transactionId:
          'SGFHFJSDF334934AKDADS494304SKFDLKFDSKLDKSDKSLDK39302LS23DSD',
      timestamp: DateTime(2022, 03, 13, 09, 12),
      asset: Asset(name: 'XBN', transferQnty: 300.000),
      transactionType: TransactionType.send,
      reciever: User(
          walletAddress: 'LKJZXE23SDD34332SSX4SZ323244',
          username: 'kent2cky',
          firstName: 'Ken',
          lastName: 'Maduka'),
    ),
    Transaction(
      transactionId:
          'CNVFDJFFK34934AKDADS494304SKFDLKFDSKLDKSDKSLDK393029VCF0VC',
      timestamp: DateTime(2022, 03, 11, 12, 45),
      asset: Asset(name: 'XBN', transferQnty: 1039.000),
      transactionType: TransactionType.receive,
      sender: User(
          walletAddress: 'CNVFDJFFK34934AKDADS494304SK',
          username: 'ric',
          firstName: 'Ric',
          lastName: 'Richard'),
    ),
    Transaction(
        transactionId:
            'DSDASFDFSD434AKDADS494304SKFDLKFDSKLDKSDKSLDK3930DFLFDKD45',
        timestamp: DateTime(2022, 03, 11, 12, 45),
        asset: Asset(
          name: 'BNR',
          transferQnty: 398.000,
          nairaExchangeRate: 2.1422,
        ),
        transactionType: TransactionType.swap,
        destinationAsset: Asset(
          name: 'XBN',
          nairaExchangeRate: 17.13164,
        )),
    Transaction(
      transactionId: 'PPOIML23SDD34332SSX4SZ323244FDLKFDSKLDKSDKSLDK39302LS9SD',
      timestamp: DateTime(2022, 03, 11, 10, 32),
      asset: Asset(name: 'XBN', transferQnty: 430.000),
      transactionType: TransactionType.send,
      reciever: User(
          walletAddress: 'PPOIML23SDD34332SSX4SZ323244',
          username: 'godswill',
          firstName: 'Godswill',
          lastName: 'Richard'),
    ),
    Transaction(
        transactionId:
            'AFDASD340D032038ZDCS8D8ZE9ZZ5Z7CZDFREKLLHKTY42KLKFL534DDF',
        timestamp: DateTime(2022, 03, 11, 12, 45),
        asset: Asset(
          name: 'XBN',
          transferQnty: 1.00,
          nairaExchangeRate: 17.13164,
        ),
        transactionType: TransactionType.swap,
        destinationAsset: Asset(
          name: 'BNR',
          nairaExchangeRate: 2.1422,
        )),
  ];

  int? currentAssetId;
  Asset? swapSource;
  Asset? swapDest;

  Transaction? transactionDetail;

  // ExpectedScanResult? _scanResult;
  // ExpectedScanResult? get scanResult => _scanResult;
  // set scanResult(ExpectedScanResult? scanResult) {
  //   _scanResult = scanResult;
  //   notifyListeners();
  // }

  PageAction _currentAction = PageAction();
  PageAction get currentAction => _currentAction;
  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }

  AppState() {
    getLoggedInState();
  }

  void resetCurrentAction() {
    _currentAction = PageAction();
  }

  void addToCart(String item) {
    cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(String item) {
    cartItems.add(item);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }

  void setSplashFinished() {
    _splashFinished = true;
    _currentAction =
        PageAction(state: PageState.replaceAll, page: LoginPageConfig);
    notifyListeners();
  }

  void login() {
    _loggedIn = true;
    saveLoginState(loggedIn);
    // _currentAction =
    //     PageAction(state: PageState.replaceAll, page: ListItemsPageConfig);
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    saveLoginState(loggedIn);
    _currentAction =
        PageAction(state: PageState.replaceAll, page: LoginPageConfig);
    notifyListeners();
  }

  void saveLoginState(bool loggedIn) async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setBool(LoggedInKey, loggedIn);
  }

  void getLoggedInState() async {
    // final prefs = await SharedPreferences.getInstance();
    // _loggedIn = prefs.getBool(LoggedInKey);
    // if (_loggedIn == null) {
    //   _loggedIn = false;
    // }
  }
}
