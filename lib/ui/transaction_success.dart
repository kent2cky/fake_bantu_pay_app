import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../local_auth.dart';
import '../router/ui_pages.dart';
import '../utility.dart';

class TransactionSuccessPage extends StatefulWidget {
  const TransactionSuccessPage({Key? key}) : super(key: key);

  @override
  _TransactionSuccessPageState createState() => _TransactionSuccessPageState();
}

class _TransactionSuccessPageState extends State<TransactionSuccessPage> {
  final Utility _utility = Utility();
  bool isAuthenticated = false;
  final Authenticator _authenticator = Authenticator();
  final iconOk = 'images/icon-ok.svg';
  final avatarImage =
      'https://pps.whatsapp.net/v/t61.24694-24/172187436_541505470458673_3253590271101490585_n.jpg?ccb=11-4&oh=01_AVzrN_wez8D19DFwJ7KgOge9ZiMorKHti1TJNVvYdAEpIw&oe=6230A14A';

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white60,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 270,
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: SvgPicture.asset(iconOk,
                            semanticsLabel: 'Acme Logo'),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        height: 220,
                        // color: Colors.red,
                      ),
                      const Text(
                        'Transaction Successful',
                        style: TextStyle(
                          fontSize: 23.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 12.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '- 1',
                                style: _utility.getTextStyle(
                                    color: Colors.red,
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: '.0000000 ',
                                style: _utility.getTextStyle(
                                    color: Colors.red,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: 'XBN',
                                style: _utility.getTextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red,
                                    fontSize: 23.0),
                              ),
                            ],
                          ),
                        ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Sent to: ',
                                    style:
                                        _utility.getTextStyle(fontSize: 12.0),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 5, 0),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.orange[800],
                                            foregroundImage:
                                                NetworkImage(avatarImage),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'ric ',
                                                    style:
                                                        _utility.getTextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              'RIC RICHARDS',
                                              style: _utility.getTextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () => {},
                                      icon: const Icon(Icons.copy_rounded),
                                      iconSize: 18,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 0.2,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                                  child: Text(
                                    'Transaction ID: ',
                                    style:
                                        _utility.getTextStyle(fontSize: 12.0),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '3a38b3ea...49227191',
                                      style: _utility.getTextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    IconButton(
                                      onPressed: () => {},
                                      icon: const Icon(Icons.copy_rounded),
                                      iconSize: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          appState.currentAction = PageAction(
                              state: PageState.replaceAll,
                              page: DashboardPageConfig);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300.0, 33.0),
                          primary: Colors.orange[800],
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          'Dashboard',
                          style: _utility.getTextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
