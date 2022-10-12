import 'package:fake_bantu_pay/models/user.dart';
import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../utility.dart';
import 'package:country_code_picker/country_code_picker.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final Utility _utility = Utility();
  final _formKey = GlobalKey<FormState>();
  final _usernameTextController = TextEditingController();
  final _firstnameTextController = TextEditingController();
  final _lastnameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _referrerTextController = TextEditingController();
  String? dialCode = '+234';
  AppState? _appState;
  final _storage = LocalStorage('fake_bantu_pay_app.json');

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey.shade800, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.grey.shade200,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Expanded(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: "Source Sans Pro",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 10.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: TextFormField(
                      controller: _usernameTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Choose a username';
                        }
                        return null;
                      },
                      autofocus: true,
                      style: _utility.getTextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        labelText: 'Username *',
                        enabledBorder: _utility.getEnabledBorderColor(),
                        labelStyle: _utility.getTextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w400),
                        hintText: 'Enter a unique username',
                        hintStyle: _utility.getTextStyle(fontSize: 11.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstnameTextController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                            autofocus: true,
                            style: _utility.getTextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: true,
                              labelText: 'First name *',
                              enabledBorder: _utility.getEnabledBorderColor(),
                              labelStyle: _utility.getTextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w400),
                              hintText: 'Enter your first name',
                              hintStyle: _utility.getTextStyle(fontSize: 11.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _lastnameTextController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                            autofocus: true,
                            style: _utility.getTextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: true,
                              labelText: 'Last name *',
                              enabledBorder: _utility.getEnabledBorderColor(),
                              labelStyle: _utility.getTextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w400),
                              hintText: 'Enter your last name',
                              hintStyle: _utility.getTextStyle(fontSize: 11.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: TextFormField(
                      controller: _emailTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }
                        return null;
                      },
                      autofocus: true,
                      style: _utility.getTextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        labelText: 'Email *',
                        enabledBorder: _utility.getEnabledBorderColor(),
                        labelStyle: _utility.getTextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w400),
                        hintText: 'Enter enter your email',
                        hintStyle: _utility.getTextStyle(fontSize: 11.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'Mobile number',
                            style: TextStyle(color: Colors.orange[800]),
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: CountryCodePicker(
                                onChanged: (code) => dialCode = code.dialCode,
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: dialCode,
                                favorite: const ['NG', 'GH', 'US'],
                                // optional. Shows only country name and flag
                                showCountryOnly: false,
                                // optional. Shows only country name and flag when popup is closed.
                                showOnlyCountryWhenClosed: false,
                                // optional. aligns the flag and the Text left
                                alignLeft: true,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _phoneTextController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid phone number';
                                    }
                                    return null;
                                  },
                                  autofocus: true,
                                  style: _utility.getTextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    alignLabelWithHint: true,
                                    enabledBorder:
                                        _utility.getEnabledBorderColor(),
                                    hintText: 'Enter your phone number',
                                    hintStyle:
                                        _utility.getTextStyle(fontSize: 11.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: _referrerTextController,
                      autofocus: true,
                      style: _utility.getTextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        labelText: 'Referrer (optional)',
                        enabledBorder: _utility.getEnabledBorderColor(),
                        labelStyle: _utility.getTextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w400),
                        hintText: 'Enter referrer\'s username',
                        hintStyle: _utility.getTextStyle(fontSize: 11.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
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
                        'Submit',
                        style: _utility.getTextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _appState?.currentAccount = User(
      username: _usernameTextController.text,
      walletAddress: _usernameTextController.text,
      firstName: _firstnameTextController.text,
      lastName: _lastnameTextController.text,
      email: _emailTextController.text,
      phoneNumber: '${dialCode!}${_phoneTextController.text}',
      referrer: _referrerTextController.text,
      password: _appState?.newPassword,
    );

    _persistUserAccount();

    _appState?.currentAction =
        PageAction(state: PageState.replace, page: EnableBiometricsPageConfig);
  }

  void _persistUserAccount() async {
    var accountString = _appState?.currentAccount?.toJSONEncodable();
    await _storage.ready.then((value) => {
          if (true) _storage.setItem('current_account', accountString),
        });
  }
}
