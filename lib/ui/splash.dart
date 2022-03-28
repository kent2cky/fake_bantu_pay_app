import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _initialized = false;
  AppState? appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);

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
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      Timer(const Duration(seconds: 1), () {
        appState?.setSplashFinished();
      });
    }
  }
}
