import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/ads_state.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/constants.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/screens/pray_screen.dart';
import 'package:mysteres/services/rosary_config_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mysteres/widgets/rounded_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/ads.dart';

class LandingScreen extends StatefulWidget {
  static const String id = "LandingPage";
  static bool checkPage = false;

  const LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late ShowInterstitial interstitial;
  late BannerAd? banner;
  late RosaryConfigService _rosaryConfigService;
  String _selectedDay = "";
  late String _selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    banner = null;
    interstitial = ShowInterstitial();
    _rosaryConfigService = RosaryConfigService();
    checkingPage();
    initDay();
    // initLanguage();
  }

  bool checkingPage() {
    return LandingScreen.checkPage = false;
  }

  void initDay() {
    setState(() {
      _selectedDay = _rosaryConfigService.getCurrentDay();
    });
  }

  void onResetPressed() {
    initDay();
    initLanguage();
  }

  void onDayChanged(String day) {
    setState(() {
      _selectedDay = day;
    });
  }

  void initLanguage() {
    setState(() {
      _selectedLanguage = _rosaryConfigService.getDefaultLanguage();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    interstitial.createInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          home: Scaffold(
            drawer: const NavigationDrawer(),
            appBar: AppBar(
              title: const Text('ROSARY'),
              backgroundColor: ColorPalette.primaryDark,
            ),
            backgroundColor: ColorPalette.primary,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(bodyChildPadding),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Configure your Prayer settings',
                          style: Font.heading1,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 1),
                                    blurRadius: 6)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width * 1,
                          height: Adaptive.h(40),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: bodyChildPadding,
                                right: bodyChildPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.language),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Select a Language',
                                      style: Font.containerText,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                languageDropdown(),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month_outlined),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Select a Day',
                                      style: Font.containerText,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    buttonDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            widgetBorderRadius),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        color: Colors.transparent,
                                        boxShadow: const [
                                          BoxShadow(color: Colors.transparent)
                                        ]),
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    value: _selectedDay,
                                    buttonHeight: 50,
                                    buttonWidth:
                                        MediaQuery.of(context).size.width * 2,
                                    dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            widgetBorderRadius),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        color: Colors.grey.shade200,
                                        boxShadow: const [
                                          BoxShadow(color: Colors.transparent)
                                        ]),
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    dropdownMaxHeight: 200,
                                    dropdownPadding: null,
                                    scrollbarRadius: const Radius.circular(40),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                    buttonElevation: 8,
                                    items: _rosaryConfigService
                                        .getDays()
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: Font.containerText,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      onDayChanged(val.toString());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedButton(
                                colour: ColorPalette.primaryDark,
                                pressed: () => onResetPressed(),
                                title: 'RESET'),
                            const SizedBox(
                              width: 20,
                            ),
                            RoundedButton(
                                colour: ColorPalette.secondaryDark,
                                pressed: () {
                                  LandingScreen.checkPage = true;
                                  if (interstitial.isAdLoaded == true) {
                                    interstitial.showInterstitialAd();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PrayScreen(
                                                selectedDay: _selectedDay)));
                                  }
                                },
                                title: 'Pray'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const Ads(),
          ),
        );
      },
    );
  }

  FutureBuilder<QuerySnapshot<Object?>> languageDropdown() {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('languages').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              style: const TextStyle(color: Colors.black, fontSize: 20),
              value: _selectedLanguage,
              buttonHeight: 50,
              buttonWidth: MediaQuery.of(context).size.width * 2,
              dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widgetBorderRadius),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  color: Colors.grey.shade200,
                  boxShadow: const [BoxShadow(color: Colors.transparent)]),
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widgetBorderRadius),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  color: Colors.transparent,
                  boxShadow: const [BoxShadow(color: Colors.transparent)]),
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 200,
              dropdownPadding: null,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
              buttonElevation: 8,
              items: _rosaryConfigService.getLanguages().map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Font.containerText,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value as String;
                });
              },
            ),
          );
        });
  }
}
