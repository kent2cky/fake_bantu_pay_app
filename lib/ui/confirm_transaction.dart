import 'package:fake_bantu_pay/models/transaction_types.dart';
import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import '../app_state.dart';
import '../local_auth.dart';
import '../models/transaction.dart';
import '../models/user.dart';
import '../utility.dart';

class ConfirmTransactionPage extends StatefulWidget {
  const ConfirmTransactionPage({Key? key}) : super(key: key);

  @override
  _ConfirmTransactionPageState createState() => _ConfirmTransactionPageState();
}

class _ConfirmTransactionPageState extends State<ConfirmTransactionPage> {
  final Utility _utility = Utility();
  bool isAuthenticated = false;
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Authenticator _authenticator = Authenticator();
  final numberFormatter = NumberFormat("#,##0.0000", "en_US");
  final avatarImage = 'images/default-user.png';
  bool isObscured = true;
  Transaction? transaction;
  AppState? appState;

  @override
  void initState() {
    super.initState();
    appState = Provider.of<AppState>(context, listen: false);
    transaction = appState!.transactionDetail;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authenticator.canCheckBiometrics(),
      builder: (
        context,
        snapshot,
      ) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(70.0), // here the desired height
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
                        'You are sending: ',
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
                                        text: transaction?.asset.transferQnty
                                            ?.toStringAsFixed(7),
                                        style: _utility.getTextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: transaction?.asset.name,
                                        style: _utility.getTextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                            fontSize: 13.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '≈ ${numberFormatter.format(transaction?.asset.nairaValue ?? 0)} NGN',
                                ),
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
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    foregroundImage: AssetImage(avatarImage),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: _getTransactionBeneficiary(
                                                    transaction!)
                                                .username,
                                            style: _utility.getTextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${_getTransactionBeneficiary(transaction!).firstName ?? 'John'} ${_getTransactionBeneficiary(transaction!).lastName ?? 'Doe'}',
                                      style: _utility.getTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      if (transaction!.memo != null) ...[
                        Text(
                          'For',
                          style: _utility.getTextStyle(fontSize: 12.0),
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
                                  horizontal: 20.0, vertical: 15.0),
                              child: Column(
                                children: [
                                  Text(
                                    transaction!.memo!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
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
                                Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: passwordTextController,
                                    obscureText: isObscured,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    validator: _validateInput,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      enabledBorder:
                                          _utility.getEnabledBorderColor(),
                                      alignLabelWithHint: true,
                                      labelText: 'Password',
                                      labelStyle: _utility.getTextStyle(),
                                      hintText: 'Enter password',
                                      hintStyle:
                                          _utility.getTextStyle(fontSize: 11.0),
                                      suffixIcon: IconButton(
                                        onPressed: () => setState(() {
                                          isObscured = !isObscured;
                                        }),
                                        icon: _utility.getIcon(isObscured),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Text(
                                    'All transactions are final. Please ensure that the receiver\'s information is accurate before sending.',
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
                      if (appState!.biometricEnabled &&
                          passwordTextController.text.isEmpty) ...[
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              bool result =
                                  await _authenticator.authenticateMe();
                              if (result) {
                                _handleSubmit(appState!);
                              }
                            } on PlatformException catch (e) {
                              if (e.code == auth_error.notEnrolled) {
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
                            'Send with Biometrics',
                            style: _utility.getTextStyle(color: Colors.white),
                          ),
                        ),
                      ] else ...[
                        ElevatedButton(
                          onPressed: () async {
                            _handlePasswordSubmit(appState!);
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
                            'Send',
                            style: _utility.getTextStyle(color: Colors.white),
                          ),
                        ),
                      ],
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
      },
    );
  }

  String? _validateInput(String? value) {
    if (value!.isEmpty) return 'Enter your password';

    if (value != appState!.currentAccount!.password) {
      return 'Wrong password, enter correct password';
    }

    return null;
  }

  void _handlePasswordSubmit(AppState appState) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _handleSubmit(appState);
  }

  void _handleSubmit(AppState appState) {
    appState.transactions?.add(transaction!);
    appState.processTransaction(transaction!);
    appState.persistTransactions();
    appState.currentAction = PageAction(
        state: PageState.addPage, page: TransactionSuccessPageConfig);
  }

  User _getTransactionBeneficiary(Transaction transaction) {
    if (transaction.transactionType == TransactionType.send) {
      return transaction.reciever!;
    } else {
      return transaction.sender!;
    }
  }
}
