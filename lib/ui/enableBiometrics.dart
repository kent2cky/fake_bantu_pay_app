import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import '../app_state.dart';
import '../local_auth.dart';
import '../utility.dart';

class EnableBiometrics extends StatefulWidget {
  const EnableBiometrics({Key? key}) : super(key: key);

  @override
  _EnableBiometricsState createState() => _EnableBiometricsState();
}

class _EnableBiometricsState extends State<EnableBiometrics> {
  final Utility _utility = Utility();

  AppState? _appState;
  bool isSwitched = false;
  final _storage = LocalStorage('fake_bantu_pay_app.json');
  final Authenticator _authenticator = Authenticator();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey.shade800, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.grey.shade300,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Enable Biometrics',
                            style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: "Source Sans Pro",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fingerprint,
                    size: 200,
                    color: Colors.orange[800],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.fingerprint,
                              size: 13,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Enable Biometrics',
                              style: _utility.getTextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          onChanged: _toggleSwitch,
                          value: isSwitched,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green[300],
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.orange[400],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      const Size(300.0, 33.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: _utility.getTextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 40.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleSwitch(bool value) async {
    try {
      bool result = await _authenticator.authenticateMe();
      if (result) {
        setState(() {
          isSwitched = !isSwitched;
        });
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled ||
          e.code == auth_error.notAvailable) {
        _utility.errorAlert(context);
      }
    }
  }

  void _handleSubmit() {
    if (!isSwitched) {
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
            height: 230,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Important',
                      style: _utility.getTextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 5.0),
                  child: Text(
                    'Are you sure you don\'t want to enable Biometrics authentication?',
                    style: _utility.getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => {
                          _submit(),
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
                          'Skip Biometrics',
                          style: _utility.getTextStyle(color: Colors.white),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () =>
                            Navigator.of(context).pop(), // dismiss dialog,
                        child: Text(
                          'Cancel',
                          style: _utility.getTextStyle(
                            fontWeight: FontWeight.w300,
                            color: const Color(0xFFEF6C00),
                          ),
                        ),
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
                      )
                    ],
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
      _submit();
    }
  }

  void _submit() {
    _appState?.biometricEnabled = isSwitched;
    _persistBiometricState();

    _appState?.currentAction = PageAction(
      state: PageState.replaceAll,
      page: DashboardPageConfig,
    );
  }

  void _persistBiometricState() async => await _storage.ready.then((value) => {
        if (true) _storage.setItem('biometricsEnabled', isSwitched),
      });
}
