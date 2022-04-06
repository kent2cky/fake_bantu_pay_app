import 'package:flutter/cupertino.dart';

import '../app_state.dart';

const String SplashPath = '/splash';
const String LoginPath = '/login';
const String CreateAccountPath = '/createAccount';
const String AgreementsPath = '/agreements';
const String ImportWalletPath = '/importWallet';
const String MyQRViewPath = '/myQrView';
const String ScanResultViewPath = '/scanResultPage';
const String ConfirmTransactionPath = '/confirmTransaction';
const String ConfirmSwapPath = '/confirmSwap';
const String TransactionSuccessPath = '/transactionSuccess';
const String SwapSuccessPath = '/swapSuccess';
const String TransactionDetailPath = '/transactionDetail';
const String DashboardPath = '/dashboard';
const String AssetDetailsPath = '/assetDetails';
const String RecieveAssetPath = '/recieveAsset';
const String ReceiveSpecificAmountPath = '/receiveSpecificAmount';
const String RequestSpecificAmountConfirmPath = '/receiveSpecificAmountConfirm';

enum Pages {
  Splash,
  Login,
  CreateAccount,
  Agreements,
  ImportWallet,
  MyQRView,
  ScanResultPage,
  ConfirmTransaction,
  TransactionSuccess,
  Dashboard,
  ConfirmSwap,
  SwapSuccess,
  TransactionDetail,
  AssetDetails,
  RecieveAsset,
  ReceiveSpecificAmount,
  RequestSpecificAmountConfirm,
}

class PageConfiguration {
  final String key;
  final String path;
  final Pages uiPage;
  PageAction? currentPageAction;

  PageConfiguration(
      {required this.key,
      required this.path,
      required this.uiPage,
      this.currentPageAction});
}

PageConfiguration SplashPageConfig = PageConfiguration(
    key: 'Splash',
    path: SplashPath,
    uiPage: Pages.Splash,
    currentPageAction: null);
PageConfiguration LoginPageConfig = PageConfiguration(
    key: 'Login',
    path: LoginPath,
    uiPage: Pages.Login,
    currentPageAction: null);
PageConfiguration CreateAccountPageConfig = PageConfiguration(
    key: 'CreateAccount',
    path: CreateAccountPath,
    uiPage: Pages.CreateAccount,
    currentPageAction: null);
PageConfiguration AgreementsPageConfig = PageConfiguration(
    key: 'Agreements',
    path: AgreementsPath,
    uiPage: Pages.Agreements,
    currentPageAction: null);
PageConfiguration ImportWalletPageConfig = PageConfiguration(
    key: 'ImportWallet',
    path: ImportWalletPath,
    uiPage: Pages.ImportWallet,
    currentPageAction: null);
PageConfiguration MyQRViewPageConfig = PageConfiguration(
    key: 'MyQRView',
    path: MyQRViewPath,
    uiPage: Pages.MyQRView,
    currentPageAction: null);
PageConfiguration ScanResultPageConfig = PageConfiguration(
    key: 'ScanResultPage',
    path: ScanResultViewPath,
    uiPage: Pages.ScanResultPage,
    currentPageAction: null);
PageConfiguration ConfirmTransactionPageConfig = PageConfiguration(
    key: 'ConfirmTransaction',
    path: ConfirmTransactionPath,
    uiPage: Pages.ConfirmTransaction,
    currentPageAction: null);
PageConfiguration ConfirmSwapPageConfig = PageConfiguration(
    key: 'ConfirmSwap',
    path: ConfirmSwapPath,
    uiPage: Pages.ConfirmSwap,
    currentPageAction: null);
PageConfiguration TransactionSuccessPageConfig = PageConfiguration(
    key: 'TransactionSuccess',
    path: TransactionSuccessPath,
    uiPage: Pages.TransactionSuccess,
    currentPageAction: null);
PageConfiguration SwapSuccessPageConfig = PageConfiguration(
    key: 'SwapSuccess',
    path: SwapSuccessPath,
    uiPage: Pages.SwapSuccess,
    currentPageAction: null);
PageConfiguration DashboardPageConfig = PageConfiguration(
    key: 'Dashboard',
    path: DashboardPath,
    uiPage: Pages.Dashboard,
    currentPageAction: null);
PageConfiguration TransactionDetailPageConfig = PageConfiguration(
    key: 'TransactionDetail',
    path: TransactionDetailPath,
    uiPage: Pages.TransactionDetail,
    currentPageAction: null);
PageConfiguration AssetDetailsPageConfig = PageConfiguration(
    key: 'AssetDetails',
    path: AssetDetailsPath,
    uiPage: Pages.AssetDetails,
    currentPageAction: null);
PageConfiguration RecieveAssetPageConfig = PageConfiguration(
    key: 'RecieveAsset',
    path: RecieveAssetPath,
    uiPage: Pages.RecieveAsset,
    currentPageAction: null);
PageConfiguration ReceiveSpecificAmountPageConfig = PageConfiguration(
    key: 'ReceiveSpecificAmount',
    path: RecieveAssetPath,
    uiPage: Pages.ReceiveSpecificAmount,
    currentPageAction: null);
PageConfiguration RequestSpecificAmountConfirmPageConfig = PageConfiguration(
    key: 'RequestSpecificAmountConfirm',
    path: RequestSpecificAmountConfirmPath,
    uiPage: Pages.RequestSpecificAmountConfirm,
    currentPageAction: null);
