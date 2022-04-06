import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/transaction.dart';
import '../models/transaction_types.dart';
import '../router/ui_pages.dart';
import '../utility.dart';
import 'package:timeago/timeago.dart' as timeago;

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  final Utility _utility = Utility();
  AppState? appState;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.grey.shade200,
            child: Column(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ikenna Maduka',
                                  style: _utility.getTextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => {},
                                  icon: Icon(Icons.navigate_next),
                                  color: Colors.orange.shade800,
                                  iconSize: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                        _settingsProperty(
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 15,
                          ),
                          property: 'Hide my Balance',
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
                        _settingsProperty(
                          icon: const Icon(
                            Icons.fingerprint,
                            size: 15,
                          ),
                          property: 'Biometrics',
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
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 30,
                              color: Colors.orange.shade800,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
}
