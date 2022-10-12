import 'dart:convert';

import 'package:fake_bantu_pay/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'models/asset.dart';
import 'models/transaction_types.dart';
import 'models/user.dart';
import 'router/ui_pages.dart';

const String LoggedInKey = 'LoggedIn';
final _storage = LocalStorage('fake_bantu_pay_app.json');

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
  String? newPassword;
  int selectedIndex = 0;
  GlobalKey? globalKey;

  bool _biometricEnabled = false;
  bool get biometricEnabled => _biometricEnabled;
  set biometricEnabled(bool isEnabled) {
    _biometricEnabled = isEnabled;
    notifyListeners();
    _persistBiometricState(isEnabled);
  }

  void _persistBiometricState(bool isEnabled) async =>
      await _storage.ready.then((value) => {
            if (true) _storage.setItem('biometricsEnabled', isEnabled),
          });

  bool _hideBalance = false;
  bool get hideBalance => _hideBalance;
  set hideBalance(bool isHidden) {
    _hideBalance = isHidden;
    notifyListeners();
    _persistBalanceState(isHidden);
  }

  void _persistBalanceState(bool isHidden) async =>
      await _storage.ready.then((value) => {
            if (true) _storage.setItem('balanceHidden', isHidden),
          });

  List<Asset>? _listedAssets;
  List<Asset>? get listedAssets => _listedAssets;
  set listedAssets(List<Asset>? assets) {
    _listedAssets = assets;
    notifyListeners();
  }

  User? _currentAccount;
  User? get currentAccount => _currentAccount;
  set currentAccount(User? account) {
    _currentAccount = account;
    notifyListeners();
  }

  List<Transaction>? _transactions;
  List<Transaction>? get transactions => _transactions;
  set transactions(List<Transaction>? transactions) {
    _transactions = transactions;
    notifyListeners();
  }

  int? currentAssetId;
  Asset? swapSource;
  Asset? swapDest;

  Transaction? _transactionDetail;
  Transaction? get transactionDetail => _transactionDetail;
  set transactionDetail(Transaction? transaction) {
    _transactionDetail = transaction;
    notifyListeners();
  }

  PageAction _currentAction = PageAction();
  PageAction get currentAction => _currentAction;
  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }

  void processTransaction(Transaction transaction) {
    switch (transaction.transactionType) {
      case TransactionType.send:
        updateSend(transaction);
        break;
      case TransactionType.swap:
        updateSwap(transaction);
        break;
      default:
    }
  }

  void persistTransactions() async {
    var transString = transactions
        ?.map((transaction) => transaction.toJSONEncodable())
        .toList();

    await _storage.setItem('transactions', transString!);

    var listedAssetString =
        _listedAssets?.map((asset) => asset.toJSONEncodable()).toList();
    await _storage.setItem('listed_assets', listedAssetString);
  }

  void updateSend(Transaction transaction) {
    var asset = listedAssets!
        .firstWhere((asset) => asset.name == transaction.asset.name);
    var newValue = asset.availableBalance! - transaction.asset.transferQnty!;
    listedAssets!
        .firstWhere((asset) => asset.name == transaction.asset.name)
        .availableBalance = newValue;
  }

  void updateSwap(Transaction transaction) {
    // get the listed asset details
    var sourceAsset = listedAssets!
        .firstWhere((asset) => asset.name == transaction.asset.name);
    var destAsset = listedAssets!.firstWhere(
        (asset) => asset.name == transaction.destinationAsset!.name);

// substract from the swap source
    var newSourceValue =
        sourceAsset.availableBalance! - transaction.asset.transferQnty!;
    // increment the swap destination
    var newDestValue = destAsset.availableBalance! +
        transaction.destinationAsset!.transferQnty!;

    // persist the new values
    listedAssets!
        .firstWhere((asset) => asset.name == transaction.asset.name)
        .availableBalance = newSourceValue;
    listedAssets!
        .firstWhere((asset) => asset.name == transaction.destinationAsset!.name)
        .availableBalance = newDestValue;
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
    if (_currentAccount == null) {
      _currentAction =
          PageAction(state: PageState.replaceAll, page: OnboardingPageConfig);
    } else {
      _currentAction =
          PageAction(state: PageState.replaceAll, page: LoginPageConfig);
    }
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
