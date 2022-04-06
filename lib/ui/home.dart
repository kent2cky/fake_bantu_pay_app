import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../models/asset.dart';
import '../router/ui_pages.dart';
import '../utility.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final Utility _utility = Utility();
  AppState? appState;
  double nairaValue = 0;
  double dollarExchangeRate = 415.92; //according to google 20/03/22
  final numberFormatter = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                height: 87.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: "Source Sans Pro",
                        ),
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                      onPressed: () => {
                        appState?.currentAction = PageAction(
                            state: PageState.addPage, page: MyQRViewPageConfig)
                      },
                      tooltip: 'QR Code Scanner',
                      icon: const Icon(
                        Icons.qr_code_scanner,
                        size: 22.0,
                      ),
                    ),
                    const Icon(
                      Icons.notifications_none,
                      size: 22.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 3),
                child: Container(
                  width: 310,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.orange[800],
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
                        horizontal: 5.0, vertical: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total Balance   ',
                              style: _utility.getTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          _getTotalBalanceNaira(),
                          style: _utility.getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _getTotalBalanceDollars(),
                          style: _utility.getTextStyle(
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
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'ASSETS ',
                      style: _utility.getTextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              if (appState != null) ...[
                for (var asset in appState!.listedAssets) ...[_listAsset(asset)]
              ]
            ],
          ),
        ],
      ),
    );
  }

  String _getTotalBalanceNaira() {
    nairaValue = 0; //zero out exist value;
    for (var asset in appState!.listedAssets) {
      nairaValue += (asset.availableBalance! * asset.nairaExchangeRate!);
    }
    return '${numberFormatter.format(nairaValue)} NGN ';
  }

  String _getTotalBalanceDollars() {
    return '${numberFormatter.format((nairaValue / dollarExchangeRate))} USD';
  }

  Widget _listAsset(Asset asset) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Container(
            width: 310,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: CircleAvatar(
                      backgroundColor: Colors.orange[800],
                      foregroundImage: AssetImage(asset.logo!),
                      maxRadius: 15,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: asset.name,
                                    style: _utility.getTextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${asset.nairaExchangeRate} NGN',
                              style: _utility.getTextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 9.0),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              numberFormatter.format(asset.availableBalance),
                              style: _utility.getTextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              '≈ ${numberFormatter.format((asset.availableBalance! * asset.nairaExchangeRate!))} NGN',
                              style: _utility.getTextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 9.0),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          appState?.currentAssetId = asset.id;
          appState?.currentAction = PageAction(
              state: PageState.addPage, page: AssetDetailsPageConfig);
        });
  }
}
