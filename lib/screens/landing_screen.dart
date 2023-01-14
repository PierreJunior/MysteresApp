import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/ads_state.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/constants.dart';
import 'package:mysteres/navigation_drawer.dart';
import 'package:mysteres/screens/pray_screen.dart';
import 'package:mysteres/services/logging_service.dart';
import 'package:mysteres/services/notification_service.dart';
import 'package:mysteres/services/rosary_config_service.dart';
import 'package:mysteres/l10n/locale_keys.g.dart';
import 'package:mysteres/widgets/custom_app_bar.dart';
import 'package:mysteres/widgets/error.dart';
import 'package:mysteres/widgets/loader.dart';
import 'package:mysteres/widgets/rounded_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:easy_localization/easy_localization.dart';

//ignore: must_be_immutable
class LandingScreen extends StatefulWidget {
  late String valueLanguage;
  static const String id = "LandingPage";
  static bool checkPage = false;

  LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late ShowInterstitial interstitial;
  late BannerAd? banner;
  late RosaryConfigService _rosaryConfigService;
  late final LoggingService _log;
  bool isLoadingLanguage = true;
  bool isLoadingWeekDays = true;
  bool loadingError = false;

  @override
  void initState() {
    super.initState();
    banner = null;
    interstitial = ShowInterstitial();
    _rosaryConfigService = RosaryConfigService();
    _log = LoggingService();
    _initialLoad();
    _checkingPage();
  }

  bool _checkingPage() {
    return LandingScreen.checkPage = false;
  }

  _initialLoad() {
    _rosaryConfigService.load().then((value) {
      setState(() {
        isLoadingLanguage = false;
        isLoadingWeekDays = false;
      });
    }).catchError((e, s) {
      _log.exception(e, s);
      loadingError = true;
    });
  }

  void onResetPressed() {
    onLanguageChanged(_rosaryConfigService.getDefaultLanguage());
  }

  void onDayChanged(String day) {
    _rosaryConfigService.setSelectedWeekDay(day);
    setState(() {});
  }

  void onLanguageChanged(String lang) {
    _rosaryConfigService.changeLanguage(lang);
    setState(() {
      isLoadingWeekDays = true;
    });

    _rosaryConfigService.loadWeekDays().then((value) {
      _rosaryConfigService.initDefaultWeekDay();
      setState(() {
        isLoadingWeekDays = false;
      });
    }).catchError((e, s) {
      Map<String, dynamic> logContext = {"selectedLanguage": lang};
      String transaction = "_LandingScreenState.onLanguageChanged";
      _log.exception(e, s, logContext, transaction);
      NotificationService.getFlushbar(LocaleKeys.errorChangeLanguage.tr(), 5,
              ColorPalette.warning, NotificationPosition.bottom)
          .show(context);
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
        if (loadingError) {
          return Error(message: LocaleKeys.errorUnexpected.tr());
        }

        return MaterialApp(
          theme: ThemeData(useMaterial3: true),
          home: Scaffold(
            drawer: const NavigationDrawer(),
            appBar: const CustomAppBar(),
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
                          LocaleKeys.landingScreenTitle.tr(),
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
                          height: Adaptive.h(45),
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
                                      LocaleKeys.dropdownLabelLanguage.tr(),
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
                                      LocaleKeys.dropdownLabelDay.tr(),
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
                                colour: ColorPalette.secondaryDark,
                                pressed: () => onResetPressed(),
                                title: LocaleKeys.btnReset.tr()),
                            const SizedBox(
                              width: 20,
                            ),
                            RoundedButton(
                                colour: ColorPalette.primaryDark,
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
                                                          .selectedWeekDay!,
                                                  selectedLanguage:
                                                      _rosaryConfigService
                                                          .selectedLanguage,
                                                )));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PrayScreen(
                                                  selectedDay:
                                                      _rosaryConfigService
                                                          .selectedWeekDay!,
                                                  selectedLanguage:
                                                      _rosaryConfigService
                                                          .selectedLanguage,
                                                )));
                                  }
                                },
                                title: LocaleKeys.btnPray.tr()),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget loadWeekDaysDropdown() {
    while (isLoadingWeekDays) {
      return const Center(
        child: Loader(),
      );
    }
    return weekDaysDropdown();
  }

  Widget loadLanguagesDropdown() {
    while (isLoadingLanguage) {
      return const Center(
        child: Loader(),
      );
    }
    return languagesDropdown();
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
