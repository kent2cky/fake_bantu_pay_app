import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../local_auth.dart';
import '../router/ui_pages.dart';
import '../utility.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  final Utility _utility = Utility();
  final Authenticator _authenticator = Authenticator();
  AppState? appState;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, value, child) {
      appState = value;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 60.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          'Settings',
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
                  height: 42.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: const [
                            Icon(Icons.perm_identity),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                              child: Text(
                                'Edit Profile',
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                foregroundImage:
                                    AssetImage('images/default-user.png'),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    appState!.currentAccount!.username!,
                                    style: _utility.getTextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: _gotoUserProfile,
                                    icon: const Icon(Icons.navigate_next),
                                    color: Colors.orange.shade800,
                                    iconSize: 30,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: _gotoUserProfile,
                    ),
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.tune_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                              child: Text(
                                'Preferences',
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _settingsProperty(
                          icon: const Icon(
                            Icons.language,
                            size: 15,
                          ),
                          property: 'Language',
                          value: 'English',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        _settingsProperty(
                          icon: const Icon(
                            Icons.currency_exchange,
                            size: 15,
                          ),
                          property: 'Currency',
                          value: 'NGN',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        _settingsProperty(
                          icon: const Icon(
                            Icons.palette,
                            size: 15,
                          ),
                          property: 'Theme',
                          value: 'Light',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.lock,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                              child: Text(
                                'Security',
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _settingsProperty(
                          icon: const Icon(
                            Icons.lock_outline_rounded,
                            size: 15,
                          ),
                          property: 'Password Management',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 15,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hide my Balance',
                                      style: _utility.getTextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Switch(
                                          onChanged: (value) {
                                            _toggleHideBalance(value, context);
                                          },
                                          value: appState!.hideBalance,
                                          activeColor: Colors.white,
                                          activeTrackColor: Colors.green[300],
                                          inactiveThumbColor: Colors.white,
                                          inactiveTrackColor:
                                              Colors.orange[400],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        _settingsProperty(
                          icon: const Icon(
                            Icons.timer_outlined,
                            size: 15,
                          ),
                          property: 'Time out',
                          value: 'after 5 minutes of inactivity!',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Icon(
                                  Icons.fingerprint,
                                  size: 15,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Biometrics',
                                      style: _utility.getTextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Switch(
                                          onChanged: (value) {
                                            _toggleSwitch(value, context);
                                          },
                                          value: appState!.biometricEnabled,
                                          activeColor: Colors.white,
                                          activeTrackColor: Colors.green[300],
                                          inactiveThumbColor: Colors.white,
                                          inactiveTrackColor:
                                              Colors.orange[400],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.account_balance_wallet_rounded,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                              child: Text(
                                'Wallet',
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _settingsProperty(
                          icon: const Icon(
                            Icons.workspaces,
                            size: 15,
                          ),
                          property: 'Curated Assets',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        _settingsProperty(
                          icon: const Icon(
                            Icons.cloud_download_outlined,
                            size: 15,
                          ),
                          property: 'Import Wallet',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        _settingsProperty(
                          icon: const Icon(
                            Icons.cloud_upload_outlined,
                            size: 15,
                          ),
                          property: 'Backup Wallet',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        _settingsProperty(
                            icon: const Icon(
                              Icons.swap_vert,
                              size: 15,
                            ),
                            property: 'Wallet Mode',
                            value: 'Mainnet'),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.more_horiz_outlined,
                              size: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                              child: Text(
                                'More',
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _settingsProperty(
                          icon: const Icon(
                            Icons.wechat_outlined,
                            size: 15,
                          ),
                          property: 'Help & Support',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        _settingsProperty(
                          icon: const Icon(
                            Icons.handshake_outlined,
                            size: 15,
                          ),
                          property: 'Terms of Use',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2,
                            thickness: 1,
                          ),
                        ),
                        _settingsProperty(
                          icon: const Icon(
                            Icons.error_outline,
                            size: 15,
                          ),
                          property: 'About BantuPay',
                          value: 'Version: 2.2.4',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () => {
                            appState?.currentAction = PageAction(
                                state: PageState.replaceAll,
                                page: LoginPageConfig),
                          },
                          icon: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 30,
                                color: Colors.orange.shade800,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.orange.shade800,
                                    fontFamily: "Source Sans Pro",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _settingsProperty({
    Icon? icon,
    String? property,
    String? value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: icon,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  property!,
                  style: _utility.getTextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    if (value != null && value.isNotEmpty) ...[
                      Text(
                        value,
                        style: _utility.getTextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.navigate_next),
                      color: Colors.orange.shade800,
                      iconSize: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSwitch(bool value, BuildContext context) async {
    try {
      bool result = await _authenticator.authenticateMe();
      if (result) {
        appState!.biometricEnabled = value;
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled ||
          e.code == auth_error.notAvailable) {
        _utility.errorAlert(context);
      }
    }
  }

  void _toggleHideBalance(bool value, BuildContext context) async {
    if (appState!.hideBalance) {
      _authenticate(context);
    } else {
      appState!.hideBalance = true;
    }
  }

  void _authenticate(BuildContext context) async {
    if (appState!.biometricEnabled) {
      try {
        bool result = await _authenticator.authenticateMe();
        if (result) {
          appState!.hideBalance = !appState!.hideBalance;
        }
      } on PlatformException catch (e) {
        if (e.code == auth_error.notEnrolled) {
          _utility.errorAlert(context);
        }
      }
    } else {
      _utility.authenticatePassword(
          context,
          appState!,
          () => {
                appState!.hideBalance = !appState!.hideBalance,
                Navigator.of(context).pop(),
              });
    }
  }

  void _gotoUserProfile() => appState?.currentAction =
      PageAction(state: PageState.addPage, page: UserProfilePageConfig);
}
