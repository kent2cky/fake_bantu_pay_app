import 'package:fake_bantu_pay/extensions.dart';
import 'package:fake_bantu_pay/models/socials.dart';
import 'package:fake_bantu_pay/router/ui_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../utility.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final Utility _utility = Utility();
  final _formKey = GlobalKey<FormState>();
  final _firstnameTextController = TextEditingController();
  final _lastnameTextController = TextEditingController();
  final _bantuTalkTextController = TextEditingController();
  final _facebookTextController = TextEditingController();
  final _twitterTextController = TextEditingController();
  final _instagramTextController = TextEditingController();
  final _linkedInTextController = TextEditingController();
  final _storage = LocalStorage('fake_bantu_pay_app.json');

  AppState? _appState;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    _firstnameTextController.text = _appState!.currentAccount!.firstName!;
    _lastnameTextController.text = _appState!.currentAccount!.lastName!;

    _facebookTextController.text =
        _appState!.currentAccount!.socials?.facebook ?? '';
    _instagramTextController.text =
        _appState!.currentAccount!.socials?.instagram ?? '';
    _twitterTextController.text =
        _appState!.currentAccount!.socials?.twitter ?? '';
    _linkedInTextController.text =
        _appState!.currentAccount!.socials?.linkedIn ?? '';
    _bantuTalkTextController.text =
        _appState!.currentAccount!.socials?.bantuTalk ?? '';
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
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Edit Profile',
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
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        foregroundImage: AssetImage('images/default-user.png'),
                        radius: 40,
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
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
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
                        const SizedBox(
                          width: 20,
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
                              labelText: 'Surname *',
                              enabledBorder: _utility.getEnabledBorderColor(),
                              labelStyle: _utility.getTextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w400),
                              hintText: 'Enter your Surname',
                              hintStyle: _utility.getTextStyle(fontSize: 11.0),
                            ),
                          ),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Column(
                      children: [
                        _showSocial('BantuTalk', 'kent2cky',
                            'images/xbn-logo.png', _bantuTalkTextController),
                        _showSocial(
                            'Facebook',
                            '@username',
                            'images/icon-facebook-circled.png',
                            _facebookTextController),
                        _showSocial(
                            'Twitter',
                            'k3nmaddy',
                            'images/icon-twitter-circled.png',
                            _twitterTextController),
                        _showSocial(
                            'Instagram',
                            '@username',
                            'images/icon-instagram.png',
                            _instagramTextController),
                        _showSocial(
                            'LinkedIn',
                            'LinkedIn profile URL',
                            'images/icon-linkedin.png',
                            _linkedInTextController),
                      ],
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
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _appState!.currentAccount!.firstName = _firstnameTextController.text;
    _appState!.currentAccount!.lastName = _lastnameTextController.text;

    if (_appState?.currentAccount!.socials == null) {
      _appState!.currentAccount!.socials = Socials();
    }

    _appState!.currentAccount!.socials!.facebook = _facebookTextController.text;
    _appState!.currentAccount!.socials!.instagram =
        _instagramTextController.text;
    _appState!.currentAccount!.socials!.bantuTalk =
        _bantuTalkTextController.text;
    _appState!.currentAccount!.socials!.linkedIn = _linkedInTextController.text;
    _appState!.currentAccount!.socials!.twitter = _twitterTextController.text;

    _persistUserAccount();

    _appState?.currentAction =
        PageAction(state: PageState.replace, page: UserProfilePageConfig);
  }

  void _persistUserAccount() async {
    var accountString = _appState?.currentAccount?.toJSONEncodable();
    await _storage.ready.then((value) => {
          if (true) _storage.setItem('current_account', accountString),
        });
  }

  Widget _showSocial(String social, String socialId, String logo,
      TextEditingController controller) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    social,
                    style: _utility.getTextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: controller,
                    autofocus: true,
                    style: _utility.getTextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      alignLabelWithHint: true,
                      enabledBorder: _utility.getEnabledBorderColor(),
                      hintText: '@username',
                      hintStyle: _utility.getTextStyle(fontSize: 11.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
