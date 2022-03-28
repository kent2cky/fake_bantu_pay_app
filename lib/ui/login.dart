import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../local_auth.dart';
import '../router/ui_pages.dart';
import '../utility.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = true;
  bool isTapped = false;
  final Authenticator _authenticator = Authenticator();
  final Utility _utility = Utility();
  AppState? _appState;

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange.shade800,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.orange.shade800,
              child: Column(
                children: [
                  const SizedBox(
                    height: 90.0,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 20.0),
                          child: Text(
                            'Welcome Back kent2cky',
                            style: TextStyle(
                              fontSize: 30.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontFamily: "Source Sans Pro",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    obscureText: true,
                    onTap: () => {
                      setState(() {
                        isTapped = true;
                      })
                    },
                    onSubmitted: (value) => _appState?.currentAction =
                        PageAction(
                            state: PageState.replace,
                            page: DashboardPageConfig),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      alignLabelWithHint: true,
                      labelText: 'Password',
                      border: isTapped ? null : InputBorder.none,
                      labelStyle: _utility.getTextStyle(),
                      hintText: 'Enter password',
                      hintStyle: _utility.getTextStyle(fontSize: 11.0),
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => {
                        _appState?.currentAction = PageAction(
                            state: PageState.addPage,
                            page: ImportWalletPageConfig)
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 9.0, 0),
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: _utility.getTextStyle(),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool result = await _authenticator.authenticateMe();
                    if (result) {
                      _appState?.currentAction = PageAction(
                          state: PageState.replace, page: DashboardPageConfig);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300.0, 33.0),
                    primary: Colors.orange[800],
                    padding: const EdgeInsets.all(0),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Login with Biometrics?',
                    style: _utility.getTextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  'or',
                  style: _utility.getTextStyle(),
                ),
                OutlinedButton(
                  onPressed: () {
                    _appState?.currentAction = PageAction(
                        state: PageState.addPage,
                        page: CreateAccountPageConfig);
                  },
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(300.0, 33.0),
                      onSurface: Colors.orange[800],
                      padding: const EdgeInsets.all(0),
                      shape: const StadiumBorder(),
                      side: const BorderSide(
                          width: 1.0, color: Color(0xFFEF6C00))),
                  child: Text(
                    'Create Account',
                    style: _utility.getTextStyle(color: Colors.orange[800]),
                  ),
                ),
                Text(
                  'Version 2.2.5',
                  style: _utility.getTextStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _appState?.currentAction =
              PageAction(state: PageState.addPage, page: MyQRViewPageConfig)
        },
        tooltip: 'QR Code Scanner',
        child: const Icon(
          Icons.qr_code_scanner,
          size: 25.0,
        ),
        backgroundColor: Colors.orange[800],
      ),
    );
  }
}
