import 'package:fake_bantu_pay/models/user.dart';
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
  bool? _hasAgreed = false;
  bool? _showError = false;
  final _formKey = GlobalKey<FormState>();
  AppState? _appState;
  String? _password;
  String? _confirmPassword;
  bool isObscured = true;

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    // _hasAgreed = appState.hasAgreed;
    return Scaffold(
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
                      autofocus: true,
                      obscureText: isObscured,
                      validator: _validateInput,
                      onFieldSubmitted: _handleSubmit,
                      onChanged: (value) => {
                        setState(() {
                          _password = value;
                        })
                      },
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        labelText: 'Password',
                        labelStyle: _utility.getTextStyle(),
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
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      obscureText: isObscured,
                      validator: _validateConfirm,
                      onFieldSubmitted: _handleSubmit,
                      onChanged: (value) => {
                        setState(() {
                          _confirmPassword = value;
                        })
                      },
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        labelText: 'Confirm Password',
                        labelStyle: _utility.getTextStyle(),
                        hintText: 'Re-enter password',
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
                  if (_showError!) ...[
                    Text(
                      'You need to accept terms',
                      style: _utility.getTextStyle(
                          color: Colors.red, fontWeight: FontWeight.w400),
                    )
                  ],
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _handleSubmit(null);
                    },
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
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateInput(String? value) {
    if (value!.isEmpty) return 'Enter password';

    if (value.length < 6) return 'Use 6 characters or more for your password';

    return null;
  }

  String? _validateConfirm(String? value) {
    if (value!.isEmpty) return 'Confirm password';

    if (value.length < 6) return 'Use 6 characters or more for your password';

    if (_password != _confirmPassword) {
      return 'Those passwords didn\'t match. Try again.';
    }

    return null;
  }

  void _handleSubmit(String? value) {
    if (!_formKey.currentState!.validate()) {
      _checkTerms();
      return;
    }

    // check that terms and conditions has been accepted
    if (!_checkTerms()) return;

    // store the new user password
    _appState?.newPassword = _password;

    _appState?.currentAction =
        PageAction(state: PageState.replace, page: AccountInfoPageConfig);
  }

  bool _checkTerms() {
    if (!_hasAgreed!) {
      // show error message if the user has not
      // agreed to terms and conditions
      setState(() {
        _showError = true;
      });
      return false;
    } else {
      setState(() {
        _showError = false;
      });
      return true;
    }
  }
}
