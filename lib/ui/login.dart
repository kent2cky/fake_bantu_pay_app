import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../local_auth.dart';
import '../router/ui_pages.dart';
import '../utility.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

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
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context, listen: false);

    return FutureBuilder(
      future: _authenticator.canCheckBiometrics(),
      builder: (
        context,
        snapshot,
      ) {
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
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              child: Text(
                                'Welcome Back \n${_appState!.currentAccount!.username}',
                                style: const TextStyle(
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          obscureText: isObscured,
                          onChanged: (value) => {
                            setState(() {
                              _password = value;
                            })
                          },
                          validator: _validateInput,
                          onFieldSubmitted: _handleSubmit,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            alignLabelWithHint: true,
                            labelText: 'Password',
                            labelStyle: _utility.getTextStyle(),
                            enabledBorder: _utility.getEnabledBorderColor(),
                            hintText: 'Enter password',
                            hintStyle: _utility.getTextStyle(fontSize: 11.0),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                isObscured = !isObscured;
                              }),
                              icon: _utility.getIcon(isObscured),
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
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 0.0, 9.0, 0),
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
                      if (_appState!.biometricEnabled && _password.isEmpty) ...[
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              bool result =
                                  await _authenticator.authenticateMe();
                              if (result) {
                                _appState?.currentAction = PageAction(
                                    state: PageState.replace,
                                    page: DashboardPageConfig);
                              }
                            } on PlatformException catch (e) {
                              if (e.code == auth_error.notEnrolled ||
                                  e.code == auth_error.notAvailable) {
                                _utility.errorAlert(context);
                              }
                            }
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              const Size(300.0, 33.0),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            'Login with Biometrics?',
                            style: _utility.getTextStyle(color: Colors.white),
                          ),
                        ),
                      ] else ...[
                        ElevatedButton(
                          onPressed: () => _handleSubmit(_password),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              const Size(300.0, 33.0),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: _utility.getTextStyle(color: Colors.white),
                          ),
                        ),
                      ],
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
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(300.0, 33.0),
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                                color: Color(0xFFEF6C00),
                                width: 1,
                                style: BorderStyle.solid),
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
                          'Create Account',
                          style:
                              _utility.getTextStyle(color: Colors.orange[800]),
                        ),
                      ),
                      Text(
                        'Version 2.2.5',
                        style: _utility.getTextStyle(),
                      ),
                    ],
                  ),
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
      },
    );
  }

  String? _validateInput(String? value) {
    if (value!.isEmpty) return 'Enter your password';

    if (value.length < 6) return 'Use 6 characters or more for your password';

    return null;
  }

  void _handleSubmit(String? value) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (value != _appState!.currentAccount?.password) {
      AlertDialog alert = AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          content: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(23),
              ),
            ),
            height: 200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Oops!',
                      style: _utility.getTextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 5.0),
                  child: Text(
                    'Password is invalid, try again.',
                    style: _utility.getTextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pop(), // dismiss dialog,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300.0, 33.0),
                      primary: Colors.orange[800],
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Continue',
                      style: _utility.getTextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ));

      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    } else {
      _appState?.currentAction =
          PageAction(state: PageState.replace, page: DashboardPageConfig);
    }
  }
}
