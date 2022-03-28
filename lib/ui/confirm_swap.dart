import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../local_auth.dart';
import '../utility.dart';

class ConfirmSwapPage extends StatefulWidget {
  const ConfirmSwapPage({Key? key}) : super(key: key);

  @override
  _ConfirmSwapPageState createState() => _ConfirmSwapPageState();
}

class _ConfirmSwapPageState extends State<ConfirmSwapPage> {
  final Utility _utility = Utility();
  bool isAuthenticated = false;
  final Authenticator _authenticator = Authenticator();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey.shade800, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.white60,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white60,
              child: Column(
                children: [
                  Container(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 20.0),
                          child: Text(
                            'Confirm Transaction',
                            style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: "Source Sans Pro",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'You are swapping: ',
                    style: _utility.getTextStyle(fontSize: 12.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Container(
                      height: 70,
                      width: 310,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: appState.swapSource!.transferQnty!
                                        .toStringAsPrecision(6),
                                    style: _utility.getTextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: ' ${appState.swapSource!.name}',
                                    style: _utility.getTextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        fontSize: 13.0),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                                '≈ ${appState.swapSource!.nairaValue!.toStringAsPrecision(7)} NGN'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'To: ',
                    style: _utility.getTextStyle(fontSize: 12.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Container(
                      // height: 70,
                      width: 310,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: appState.swapDest != null
                                        ? appState.swapDest!.transferQnty!
                                            .toStringAsPrecision(7)
                                        : '0',
                                    style: _utility.getTextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(
                                    text: ' ${appState.swapDest!.name}',
                                    style: _utility.getTextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        fontSize: 13.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Container(
                      width: 310,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15.0),
                        child: Column(
                          children: [
                            TextField(
                              obscureText: true,
                              onSubmitted: (value) => {
                                appState.currentAction = PageAction(
                                    state: PageState.addPage,
                                    page: SwapSuccessPageConfig),
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabledBorder: _utility.getEnabledBorderColor(),
                                alignLabelWithHint: true,
                                labelText: 'Password',
                                labelStyle: _utility.getTextStyle(),
                                hintText: 'Enter password',
                                hintStyle:
                                    _utility.getTextStyle(fontSize: 11.0),
                                suffixIcon: TextButton(
                                  onPressed: () => {},
                                  style: TextButton.styleFrom(
                                    fixedSize: const Size(20.0, 20.2),
                                  ),
                                  child: const Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.black,
                                    size: 17.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: Text(
                                'Please ensure the assets you are swapping are accurate.',
                                style: _utility.getTextStyle(
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5,
                                    fontSize: 12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool result = await _authenticator.authenticateMe();
                      if (result) {
                        appState.currentAction = PageAction(
                            state: PageState.replace,
                            page: SwapSuccessPageConfig);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300.0, 33.0),
                      primary: Colors.orange[800],
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Send with Biometrics',
                      style: _utility.getTextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
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
