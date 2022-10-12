import 'package:fake_bantu_pay/extensions.dart';
import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../utility.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final Utility _utility = Utility();
  final numberFormatter = NumberFormat("#,##0.0000", "en_US");
  final _formKey = GlobalKey<FormState>();
  AppState? _appState;

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
    return Consumer<AppState>(
      builder: ((context, appState, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(70.0), // here the desired height
            child: AppBar(
              iconTheme: IconThemeData(
                color: Colors.grey.shade800, //change your color here
              ),
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'My Profile',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: "Source Sans Pro",
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () =>
                                          _appState?.currentAction = PageAction(
                                              state: PageState.addPage,
                                              page: EditProfilePageConfig),
                                      icon: const Icon(Icons.edit)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.grey,
                            foregroundImage:
                                AssetImage('images/default-user.png'),
                            radius: 40,
                          ),
                          Text(
                            '${_appState!.currentAccount!.firstName!.capitalize()} ${_appState!.currentAccount!.lastName!.capitalize()}',
                            style: _utility.getTextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            _appState!.currentAccount!.username!,
                            style: _utility.getTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Referral ID: ${_appState!.currentAccount!.username!}',
                            style: _utility.getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Receive from non BantuPay Wallet',
                              style: _utility.getTextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'GAVLU3R6M3DSLFAS32429SDLFSLADHJRDORNFKR3',
                                  style: _utility.getTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  ),
                                ),
                                IconButton(
                                  color: Colors.orange[800],
                                  onPressed: () => {
                                    Clipboard.setData(
                                      const ClipboardData(
                                        text:
                                            "GAVLU3R6M3DSLFAS32429SDLFSLADHJRDORNFKR3",
                                      ),
                                    ),
                                    _showSnackBar('public key', context),
                                  },
                                  icon: const Icon(Icons.copy_rounded),
                                  iconSize: 18,
                                ),
                              ],
                            ),
                            const Divider(
                              height: 2,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email *',
                              style: _utility.getTextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _appState!.currentAccount!.email!,
                                  style: _utility.getTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  ),
                                ),
                                IconButton(
                                  color: Colors.orange[800],
                                  onPressed: () => {},
                                  icon: const Icon(Icons.shield),
                                  iconSize: 18,
                                ),
                              ],
                            ),
                            const Divider(
                              height: 2,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile number ',
                              style: _utility.getTextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _appState!.currentAccount!.phoneNumber!,
                                  style: _utility.getTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  ),
                                ),
                                IconButton(
                                  color: Colors.orange[800],
                                  onPressed: () => {},
                                  icon: const Icon(Icons.shield),
                                  iconSize: 18,
                                ),
                              ],
                            ),
                            const Divider(
                              height: 2,
                              thickness: 1,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Row(children: [
                          Text(
                            'Social ID',
                            style: _utility.getTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.orange[800],
                            ),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _showSocial(
                                  'BantuTalk',
                                  _getId(_appState!
                                      .currentAccount!.socials?.bantuTalk),
                                  'images/xbn-logo.png'),
                              _showSocial(
                                  'Facebook',
                                  _getId(_appState!
                                      .currentAccount!.socials?.facebook),
                                  'images/icon-facebook-circled.png'),
                              _showSocial(
                                  'Twitter',
                                  _getId(_appState!
                                      .currentAccount!.socials?.twitter),
                                  'images/icon-twitter-circled.png'),
                              _showSocial(
                                  'Instagram',
                                  _getId(_appState!
                                      .currentAccount!.socials?.instagram),
                                  'images/icon-instagram.png'),
                              _showSocial(
                                  'LinkedIn',
                                  _getId(_appState!
                                      .currentAccount!.socials?.linkedIn),
                                  'images/icon-linkedin.png'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _getId(String? socialId) {
    if (socialId == null || socialId.isEmpty) {
      return '@username';
    } else {
      return socialId;
    }
  }

  Widget _showSocial(String social, String socialId, String logo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: CircleAvatar(
              foregroundImage: AssetImage(logo),
              maxRadius: 10,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      social,
                      style: _utility.getTextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      socialId,
                      style: _utility.getTextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
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

  void _showSnackBar(String rel, BuildContext context) {
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
}
