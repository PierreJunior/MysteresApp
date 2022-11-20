import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/ads_state.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/constants.dart';
import 'package:mysteres/navigation_drawer.dart';
import 'package:mysteres/screens/pray_screen.dart';
import 'package:mysteres/screens/language_settings_screen.dart';
import 'package:mysteres/services/rosary_config_service.dart';
import 'package:mysteres/widgets/rounded_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/ads.dart';

//ignore: must_be_immutable
class LandingScreen extends StatefulWidget {
  late String valueLanguage;
  static const String id = "LandingPage";
  static bool checkPage = false;

  LandingScreen({
    Key? key,
    required this.valueLanguage,
  }) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late LanguageSettings langSettings;
  late ShowInterstitial interstitial;
  late BannerAd? banner;
  late RosaryConfigService _rosaryConfigService;

  String get savedLanguagePref => const LanguageSettings().getDefaultLanguage();

  @override
  void initState() {
    super.initState();
    banner = null;
    getSavedLanguage();
    interstitial = ShowInterstitial();
    _rosaryConfigService = RosaryConfigService();
    checkingPage();
    // onLanguageChanged(widget.valueLanguage);
  }

  Future getSavedLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.valueLanguage = prefs.getString(savedLanguagePref)!;
    onLanguageChanged(widget.valueLanguage);
  }

  bool checkingPage() {
    return LandingScreen.checkPage = false;
  }

  void onResetPressed() {
    getSavedLanguage();
    _rosaryConfigService.reset();
    setState(() {});
  }

  void onDayChanged(String day) {
    _rosaryConfigService.setSelectedWeekDay(day);
    setState(() {});
  }

  void onLanguageChanged(String lang) {
    _rosaryConfigService.changeLanguage(lang);
    setState(() {});
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
                                loadLanguagesDropdown(),
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
                                loadWeekDaysDropdown(),
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
                                                selectedDay:
                                                    _rosaryConfigService
                                                        .selectedWeekDay!)));
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

  FutureBuilder loadWeekDaysDropdown() {
    return FutureBuilder(
      future: _rosaryConfigService.getWeekDaysFuture(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return weekDaysDropdown();
            } else {
              return const Text('Error: Unexpected error');
            }
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  FutureBuilder loadLanguagesDropdown() {
    return FutureBuilder(
        future: _rosaryConfigService.getLanguagesFuture(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return languagesDropdown();
        });
  }

  Widget weekDaysDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widgetBorderRadius),
            border: Border.all(
              color: Colors.grey,
            ),
            color: Colors.transparent,
            boxShadow: const [BoxShadow(color: Colors.transparent)]),
        isExpanded: true,
        style: const TextStyle(color: Colors.black, fontSize: 20),
        value: _rosaryConfigService.selectedWeekDay,
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
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownPadding: null,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        buttonElevation: 8,
        items: _rosaryConfigService.getWeekDays().map((String value) {
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
          onDayChanged(value!);
        },
      ),
    );
  }

  Widget languagesDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        style: const TextStyle(color: Colors.black, fontSize: 20),
        value: _rosaryConfigService.selectedLanguage,
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
          onLanguageChanged(value!);
        },
      ),
    );
  }
}
