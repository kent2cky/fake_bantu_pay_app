import 'package:fake_bantu_pay/ui/create_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../local_auth.dart';
import '../router/ui_pages.dart';
import '../utility.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool loading = true;
  bool isTapped = false;
  final Authenticator _authenticator = Authenticator();
  final Utility _utility = Utility();
  AppState? _appState;
  final _formKey = GlobalKey<FormState>();
  String? _password;

  @override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.orange.shade800,
      body: Column(
        children: [
          SizedBox(
            height: 650,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('BantuPay Wallet',
                          style: _utility.getTextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      Text(
                        'The Spirit of Ubuntu',
                        style: _utility.getTextStyle(
                            fontSize: 17, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => {
                  _appState?.currentAction = PageAction(
                      state: PageState.addPage, page: CreateAccountPageConfig),
                },
                child: Text(
                  'Create Wallet',
                  style: _utility.getTextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  fixedSize: MaterialStateProperty.all(
                    const Size(180, 60),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
