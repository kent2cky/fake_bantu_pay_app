import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'router/back_dispatcher.dart';
import 'router/route_parser.dart';
import 'router/router_delegate.dart';
import 'router/ui_pages.dart';

void main() {
  runApp(const FakeBantuPay());
}

class FakeBantuPay extends StatefulWidget {
  const FakeBantuPay({Key? key}) : super(key: key);

  @override
  _FakeBantuPayState createState() => _FakeBantuPayState();
}

class _FakeBantuPayState extends State<FakeBantuPay> {
  FakeBantuPayBackButtonDispatcher? backButtonDispatcher;
  final appState = AppState();
  FakeBantuPayRouterDelegate? delegate;
  final parser = FakeBantuPayRouteParser();

  _FakeBantuPayState() {
    delegate = FakeBantuPayRouterDelegate(appState);
    delegate?.setNewRoutePath(SplashPageConfig);
    backButtonDispatcher = FakeBantuPayBackButtonDispatcher(delegate!);
  }

  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => appState,
      child: MaterialApp.router(
        title: 'FakeBantuPayApp',
        // home: root(context),
        theme: ThemeData(
          // change the focus border color of the TextField
          colorScheme:
              ThemeData().colorScheme.copyWith(primary: Colors.orange[800]),
          // change the focus border color when the errorText is set
          errorColor: Colors.red,
          primaryColor: Colors.orange[800],
        ),
        // backButtonDispatcher: backButtonDispatcher,
        routerDelegate: delegate!,
        routeInformationParser: parser,
        backButtonDispatcher: backButtonDispatcher,
      ),
    );
  }
}
