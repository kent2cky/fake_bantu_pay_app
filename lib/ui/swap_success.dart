import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
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
                          appState.selectedIndex = 0;
                          appState.currentAction = PageAction(
                              state: PageState.replaceAll,
                              page: DashboardPageConfig);
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(300.0, 33.0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
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
