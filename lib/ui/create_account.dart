import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../utility.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final Utility _utility = Utility();
  bool isTapped = false;
  bool? _hasAgreed = false;

  Future<bool> _willPopScopeCall() async {
// code to show toast or modal
    return true; // return true to exit app or return false to cancel exit
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    // _hasAgreed = appState.hasAgreed;
    return WillPopScope(
      onWillPop: _willPopScopeCall,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.orange.shade800,
          ),
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
                              'Create Wallet',
                              style: TextStyle(
                                fontSize: 30.0,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontFamily: "Source Sans Pro",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 90.0,
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
                      autofocus: true,
                      obscureText: true,
                      onTap: () => {
                        setState(() {
                          isTapped = true;
                        })
                      },
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
                  const SizedBox(
                    height: 5.0,
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
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        labelText: 'Confirm Password',
                        border: isTapped ? null : InputBorder.none,
                        labelStyle: _utility.getTextStyle(),
                        hintText: 'Re-enter password',
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
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _hasAgreed,
                          side: BorderSide(
                            width: 2.0,
                            color: Colors.orange.shade800,
                          ),
                          activeColor: Colors.orange.shade800,
                          onChanged: (value) {
                            print('I have been checked');
                            setState(() {
                              _hasAgreed = value;
                            });
                          },
                        ),
                        Expanded(
                            child: SizedBox(
                          width: 500.0,
                          child: Wrap(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: _utility.getTextStyle(fontSize: 11.0),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'I have read and agree to '),
                                    TextSpan(
                                        text:
                                            'BantuPay\'s Terms and Conditions ',
                                        style: _utility.getTextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.orange.shade800,
                                            fontSize: 10.0),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('Terms of Service"');
                                            appState.currentAction = PageAction(
                                                state: PageState.addPage,
                                                page: AgreementsPageConfig);
                                          }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      print('I am summoned');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300.0, 33.0),
                      primary: Colors.orange[800],
                      padding: const EdgeInsets.all(0),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Continue',
                      style: _utility.getTextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
