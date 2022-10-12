import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import '../app_state.dart';
import '../local_auth.dart';
import '../models/asset.dart';
import '../router/ui_pages.dart';
import '../utility.dart';

class AssetDetails extends StatefulWidget {
  const AssetDetails({Key? key}) : super(key: key);

  @override
  State<AssetDetails> createState() => _AssetDetailsState();
}

class _AssetDetailsState extends State<AssetDetails> {
  final Utility _utility = Utility();
  final numberFormatter = NumberFormat("#,##0", "en_US");
  final Authenticator _authenticator = Authenticator();
  bool isObscured = true;
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  AppState? _appState;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: ((context, appState, child) {
      _appState = appState;
      final currentAsset = appState.listedAssets?.firstWhere(
        (asset) => asset.id == appState.currentAssetId!,
      );
      return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey.shade800, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.grey.shade300,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: 37.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            currentAsset!.name!,
                            style: const TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 3),
                    child: Container(
                      width: 310,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.orange[800],
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
                            horizontal: 5.0, vertical: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Available Balance   ',
                                  style: _utility.getTextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if (appState.hideBalance) {
                                      _authenticate(appState);
                                    } else {
                                      appState.hideBalance =
                                          !appState.hideBalance;
                                    }
                                  },
                                  icon: _utility
                                      .getWhiteIcon(appState.hideBalance),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              _getAssetBalance(appState, currentAsset),
                              style: _utility.getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _getAssetNairaEquivalent(appState, currentAsset),
                              style: _utility.getTextStyle(
                                // fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Container(
                      width: 310,
                      height: 200,
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
                            horizontal: 25.0, vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.orange[800],
                              foregroundImage: AssetImage(currentAsset.logo!),
                              maxRadius: 25,
                            ),
                            Text(
                              currentAsset.fullName ?? '',
                              style: _utility.getTextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              currentAsset.description ?? '',
                              style: _utility.getTextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              currentAsset.issuer ?? '',
                              style: _utility.getTextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 200.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            appState.currentAction = PageAction(
                                state: PageState.addPage,
                                page: ScanResultPageConfig),
                          },
                          child: Text(
                            'Send',
                            style: _utility.getTextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              const Size(160, 70),
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
                        ),
                        OutlinedButton(
                          onPressed: () => {
                            appState.currentAction = PageAction(
                                state: PageState.addPage,
                                page: RecieveAssetPageConfig),
                          },
                          child: Text(
                            'Recieve',
                            style: _utility.getTextStyle(
                                fontWeight: FontWeight.w300,
                                color: const Color(0xFFEF6C00),
                                fontSize: 18),
                          ),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              const Size(160, 70),
                            ),
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                  color: Color(0xFFEF6C00),
                                  width: 1,
                                  style: BorderStyle.solid),
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
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
      );
    }));
  }

  void _authenticate(AppState appState) async {
    if (appState.biometricEnabled) {
      try {
        bool result = await _authenticator.authenticateMe();
        if (result) {
          appState.hideBalance = !appState.hideBalance;
        }
      } on PlatformException catch (e) {
        if (e.code == auth_error.notEnrolled) {
          _utility.errorAlert(context);
        }
      }
    } else {
      _utility.authenticatePassword(
          context,
          appState,
          () => {
                _appState!.hideBalance = !_appState!.hideBalance,
                Navigator.of(context).pop(),
              });
    }
  }

  String _getAssetBalance(AppState appState, Asset asset) {
    if (appState.hideBalance) return '*****';

    return '${numberFormatter.format(asset.availableBalance)} ${asset.name}';
  }

  String _getAssetNairaEquivalent(AppState appState, Asset asset) {
    if (appState.hideBalance) return '';

    return '≈ ${numberFormatter.format((asset.availableBalance! * asset.nairaExchangeRate!))} NGN';
  }
}
