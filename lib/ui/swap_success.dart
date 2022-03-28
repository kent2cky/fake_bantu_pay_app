import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../local_auth.dart';
import '../router/ui_pages.dart';
import '../utility.dart';

class SwapSuccessPage extends StatefulWidget {
  const SwapSuccessPage({Key? key}) : super(key: key);

  @override
  _SwapSuccessPageState createState() => _SwapSuccessPageState();
}

class _SwapSuccessPageState extends State<SwapSuccessPage> {
  final Utility _utility = Utility();
  bool isAuthenticated = false;
  final Authenticator _authenticator = Authenticator();
  final iconOk = 'images/icon-ok.svg';

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white60,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 350,
                    child: Center(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: SvgPicture.asset(iconOk,
                            semanticsLabel: 'Acme Logo'),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        height: 295,
                        // color: Colors.red,
                      ),
                      const Text(
                        'Success!',
                        style: TextStyle(
                          fontSize: 23.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 20,
                        // color: Colors.red,
                      ),
                      const Text(
                        'Transaction Successful!',
                        style: TextStyle(
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 55,
                        // color: Colors.red,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          appState.currentAction = PageAction(
                              state: PageState.replace,
                              page: DashboardPageConfig);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300.0, 33.0),
                          primary: Colors.orange[800],
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          'Dashboard',
                          style: _utility.getTextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
