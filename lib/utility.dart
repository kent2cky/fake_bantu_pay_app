import 'package:app_settings/app_settings.dart';
import 'package:fake_bantu_pay/app_state.dart';
import 'package:flutter/material.dart';

class Utility {
  TextStyle getTextStyle(
      {FontWeight? fontWeight = FontWeight.w300,
      double? fontSize,
      Color? color = const Color.fromARGB(255, 124, 123, 123),
      double letterSpacing = 0}) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      fontSize: fontSize,
    );
  }

  UnderlineInputBorder getEnabledBorderColor() => const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
      );

  Future<bool?> errorAlert(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Fingerprint required'),
            actions: [
              TextButton(
                child: Text(
                  'CANCEL',
                  style: getTextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                onPressed: () => Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop(false),
              ),
              TextButton(
                  child: Text(
                    'GO TO SETTINGS',
                    style: getTextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  onPressed: () async {
                    await AppSettings.openSecuritySettings();
                  }),
            ],
            content: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Text(
                'Fingerprint is not set up on your device. Go to \'Settings > Security\' to add your fingerprint',
                style: getTextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        });
  }

  void showSnackBar(String rel, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange[800],
        content: Text('$rel copied successfully'),
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: Colors.white,
          onPressed: () => {
            ScaffoldMessenger.of(context).clearSnackBars(),
          },
        ),
      ),
    );
  }

  Widget getIcon(bool isObscured) {
    if (isObscured) {
      return const Icon(
        Icons.remove_red_eye_outlined,
        color: Colors.black,
        size: 17.0,
      );
    } else {
      return const Image(
        image: AssetImage('images/icon-invisible.png'),
        width: 17,
      );
    }
  }

  Widget getWhiteIcon(bool isObscured) {
    if (isObscured) {
      return const Icon(
        Icons.remove_red_eye_outlined,
        color: Colors.white,
        size: 17.0,
      );
    } else {
      return const Image(
        image: AssetImage('images/icon-invisible-white.png'),
        width: 17,
      );
    }
  }

  void authenticatePassword(
      BuildContext context, AppState appState, Function callBack) {
    bool isObscured = true;
    final _formKey = GlobalKey<FormState>();
    String _password = '';
    StatefulBuilder builder = StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          content: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(23),
              ),
            ),
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Please authenticate to show your balances',
                      style: getTextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      obscureText: isObscured,
                      onChanged: (value) => {
                        setState(() {
                          _password = value;
                        })
                      },
                      validator: _validateInput,
                      onFieldSubmitted: (value) =>
                          _handleSubmit(context, value, _formKey, appState),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        labelText: 'Password',
                        labelStyle: getTextStyle(),
                        enabledBorder: getEnabledBorderColor(),
                        hintText: 'Enter password',
                        hintStyle: getTextStyle(fontSize: 11.0),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            isObscured = !isObscured;
                          }),
                          icon: getIcon(isObscured),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_handleSubmit(
                          context, _password, _formKey, appState)) {
                        callBack();
                      }
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
                      style: getTextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });

    showDialog(
        context: context,
        builder: (context) {
          return builder;
        });
  }

  bool _handleSubmit(BuildContext context, String? value,
      GlobalKey<FormState> formKey, AppState appState) {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    if (value != appState.currentAccount?.password) {
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
                      style: getTextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 5.0),
                  child: Text(
                    'Password is invalid, try again.',
                    style: getTextStyle(
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
                      style: getTextStyle(color: Colors.white),
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
      return false;
    } else {
      return true;
    }
  }

  String? _validateInput(String? value) {
    if (value!.isEmpty) return 'Enter your password';

    if (value.length < 6) return 'Use 6 characters or more for your password';

    return null;
  }
}
