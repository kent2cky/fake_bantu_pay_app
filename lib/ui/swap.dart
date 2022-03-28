// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../models/asset.dart';
import '../router/ui_pages.dart';
import '../utility.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Swap extends StatefulWidget {
  const Swap({Key? key}) : super(key: key);

  @override
  _SwapState createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  @override
  final Utility _utility = Utility();
  final numberFormatter = NumberFormat("#,##0.0000", "en_US");
  final textController = TextEditingController();
// Initial Selected Value
  double? sliderValue = 0;

  // List of items in our dropdown menu
  List<Asset>? assets;
  List<String>? sourceItems;
  List<String>? destinationItems;
  Asset? sourceAsset;
  Asset? destinationAsset;
  String? sourcesliderValue;
  String? _transferQnty;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      assets = [
        Asset(
          name: 'XBN',
          logo: 'images/xbn-logo.png',
          availableBalance: 1090.7750908,
          nairaExchangeRate: 17.13164,
          nairaValue: 0.0,
        ),
        Asset(
          name: 'BNR',
          logo: 'images/bnr-logo.png',
          availableBalance: 15.9991808,
          nairaExchangeRate: 2.1422,
          nairaValue: 0.0,
        )
      ];

      sourceItems = [
        'XBN',
        'BNR',
      ];

      destinationItems = [
        'XBN',
        'BNR',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) => SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    Container(
                      height: 93.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Expanded(
                            child: Text(
                              'Swap',
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
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 3),
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
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'From ',
                                    style:
                                        _utility.getTextStyle(fontSize: 12.0),
                                  ),
                                  if (sourceAsset != null &&
                                      sourceAsset!.name!.isNotEmpty) ...[
                                    _myDropdown(
                                        items: sourceItems!,
                                        value: sourceAsset!.name!,
                                        hint: 'Select source asset',
                                        validator: (value) {
                                          if (sourceAsset == null ||
                                              sourceAsset!.name!.isEmpty) {
                                            return 'Select an asset to swap from';
                                          } else {
                                            return null;
                                          }
                                        },
                                        changed: (value) => {
                                              if (value!.isNotEmpty)
                                                {
                                                  sourceAsset = assets!
                                                      .firstWhere((element) =>
                                                          element.name ==
                                                          value),
                                                  setState(() {
                                                    destinationItems!
                                                        .removeWhere(
                                                            (element) =>
                                                                element ==
                                                                value);
                                                  })
                                                },
                                            }),
                                  ] else ...[
                                    _myDropdown(
                                        items: sourceItems!,
                                        hint: 'Select source asset',
                                        validator: (value) {
                                          if (sourceAsset == null ||
                                              sourceAsset!.name!.isEmpty) {
                                            return 'Select an asset to swap from';
                                          } else {
                                            return null;
                                          }
                                        },
                                        changed: (value) => {
                                              if (value!.isNotEmpty)
                                                {
                                                  sourceAsset = assets!
                                                      .firstWhere((element) =>
                                                          element.name ==
                                                          value),
                                                  setState(() {
                                                    destinationItems!
                                                        .removeWhere(
                                                            (element) =>
                                                                element ==
                                                                value);
                                                  })
                                                },
                                            }),
                                  ]
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                              child: Center(
                                child: Image.asset(
                                  'images/icon-below.png',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'To',
                                    style:
                                        _utility.getTextStyle(fontSize: 12.0),
                                  ),
                                  if (destinationAsset != null &&
                                      destinationAsset!.name!.isNotEmpty) ...[
                                    _myDropdown(
                                        items: destinationItems!,
                                        value: destinationAsset!.name!,
                                        validator: (value) {
                                          if (destinationAsset == null ||
                                              destinationAsset!.name!.isEmpty) {
                                            return 'Select an asset to swap to';
                                          } else {
                                            return null;
                                          }
                                        },
                                        hint: 'Select destination asset',
                                        changed: (value) => {
                                              if (value!.isNotEmpty)
                                                {
                                                  destinationAsset = assets!
                                                      .firstWhere((element) =>
                                                          element.name ==
                                                          value),
                                                  setState(() {
                                                    sourceItems!.removeWhere(
                                                        (element) =>
                                                            element == value);
                                                  }),
                                                }
                                            }),
                                  ] else ...[
                                    _myDropdown(
                                        items: destinationItems!,
                                        hint: 'Select destination asset',
                                        validator: (value) {
                                          if (destinationAsset == null ||
                                              destinationAsset!.name!.isEmpty) {
                                            return 'Select an asset to swap to';
                                          } else {
                                            return null;
                                          }
                                        },
                                        changed: (value) => {
                                              if (value!.isNotEmpty)
                                                {
                                                  destinationAsset = assets!
                                                      .firstWhere((element) =>
                                                          element.name ==
                                                          value),
                                                  setState(() {
                                                    sourceItems!.removeWhere(
                                                        (element) =>
                                                            element == value);
                                                  }),
                                                }
                                            }),
                                  ]
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (sourceAsset == null ||
                                      sourceAsset!.transferQnty == null ||
                                      sourceAsset!.transferQnty! <= 0) {
                                    return 'Enter amount to swap';
                                  }
                                  return null;
                                },
                                style: _utility.getTextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w400),
                                controller: textController,
                                onChanged: _onTextChanged,
                                decoration: InputDecoration(
                                  enabledBorder:
                                      _utility.getEnabledBorderColor(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  alignLabelWithHint: true,
                                  labelText: 'Amount to Swap',
                                  labelStyle: _utility.getTextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300),
                                  hintText: '0',
                                  hintStyle:
                                      _utility.getTextStyle(fontSize: 11.0),
                                ),
                              ),
                            ),
                            if (sourceAsset != null &&
                                sourceAsset!.name!.isNotEmpty) ...[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 3.0, 20.0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '≈ ${numberFormatter.format(sourceAsset!.nairaValue)} NGN',
                                      style: _utility.getTextStyle(
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      assets!
                                          .firstWhere((element) =>
                                              element.name == sourceAsset!.name)
                                          .availableBalance
                                          .toString(),
                                      style: _utility.getTextStyle(
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(
                              height: 40.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    if (sourceAsset != null &&
                        sourceAsset!.name!.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SfSlider(
                          min: 0,
                          max: 100,
                          value: sliderValue,
                          onChanged: _onSliderChanged,
                          onChangeEnd: _calculateExchangeRate,
                          interval: 25,
                          stepSize: 1,
                          inactiveColor: Colors.grey[900],
                          showTicks: true,
                          tooltipTextFormatterCallback: _setToolTip,
                          showLabels: true,
                          enableTooltip: true,
                          // minorTicksPerInterval: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                    ElevatedButton(
                      onPressed: () => _handleSubmit(appState),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300.0, 33.0),
                        primary: Colors.orange[800],
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        'Swap',
                        style: _utility.getTextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _myDropdown({
    required List<String> items,
    String? hint,
    String? value,
    required String? Function(String?) validator,
    required void Function(String?) changed,
  }) {
    return DropdownButtonFormField(
      validator: validator,
      decoration: const InputDecoration.collapsed(
          hintText: ''), // used to remove the annoying underline
      value: value,
      hint: Text(
        hint!,
        style: _utility.getTextStyle(fontSize: 11.0),
      ),
      // Down Arrow Icon
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 25.0,
      ),

      // Array list of items
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 15,
                backgroundColor: Colors.orange[800],
                child: Image.asset(
                  assets!.firstWhere((element) => element.name == item).logo!,
                  width: 50,
                  height: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                child: Text(
                  item,
                  style: _utility.getTextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? swapFrom) {
        changed(swapFrom!);
      },
      isExpanded: true,
    );
  }

  _onSliderChanged(dynamic newValue) {
    if (sourceAsset != null && sourceAsset!.name!.isNotEmpty) {
      setState(() {
        sliderValue = newValue;
        sourceAsset!.transferQnty =
            (newValue / 100) * sourceAsset!.availableBalance;
        _transferQnty = sourceAsset!.transferQnty!.toStringAsPrecision(7);
        textController.text = _transferQnty!;
        textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length));
      });
    }
  }

  _onTextChanged(String value) {
    if (sourceAsset != null) {
      setState(() {
        sourceAsset!.transferQnty = double.tryParse(value) ?? 0.0;
        textController.selection = TextSelection.fromPosition(
            TextPosition(offset: textController.text.length));
      });
      _calculateExchangeRate(value);
    }
  }

  _calculateExchangeRate(_) {
    setState(() {
      if (sourceAsset != null && sourceAsset!.transferQnty != null) {
        sourceAsset!.nairaValue =
            (sourceAsset!.transferQnty! * sourceAsset!.nairaExchangeRate!);
      }
    });
  }

  String _setToolTip(dynamic actualValue, String formattedText) {
    actualValue = actualValue.round();
    return '$actualValue%';
  }

  void _handleSubmit(AppState appState) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (sourceAsset!.transferQnty! > (sourceAsset!.availableBalance! - 6)) {
      AlertDialog alert = AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          content: Center(
            child: Container(
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
                        style: _utility.getTextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5.0),
                    child: Text(
                      'You must maintain a min balance of 6 ${sourceAsset!.name}',
                      style: _utility.getTextStyle(
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
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300.0, 33.0),
                        primary: Colors.orange[800],
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        'Continue',
                        style: _utility.getTextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));

      showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    } else {
      appState.swapSource = sourceAsset;
      destinationAsset!.transferQnty =
          sourceAsset!.nairaValue! / destinationAsset!.nairaExchangeRate!;
      appState.swapDest = destinationAsset;
      appState.currentAction = PageAction(
        state: PageState.addPage,
        page: ConfirmSwapPageConfig,
      );
    }
  }
}
