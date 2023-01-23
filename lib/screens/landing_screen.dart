import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/ads_state.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/constants.dart';
import 'package:mysteres/models/rosary_config_model.dart';
import 'package:mysteres/navigation_drawer.dart';
import 'package:mysteres/screens/pray_screen.dart';
import 'package:mysteres/services/consent_service.dart';
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
  bool isLoadingLanguage = true;
  bool isLoadingWeekDays = true;
  bool loadingError = false;
  bool consentGiven = false;
  bool allPrayerType = true;

  @override
  void initState() {
    super.initState();
    banner = null;
    ConsentService(consentGiven).initConsent();
    interstitial = ShowInterstitial();
    _rosaryConfigService = RosaryConfigService();
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
      Map<String, dynamic> logContext = {
        "selectedLanguage": _rosaryConfigService.selectedLanguage
      };
      LoggingService.exception(e, s,
          context: logContext, transaction: 'LandingScreen._initialLoad');
      setState(() {
        isLoadingLanguage = false;
        isLoadingWeekDays = false;
      });
      NotificationService.getFlushbar(
              message: LocaleKeys.errorUnexpected.tr(),
              color: ColorPalette.warning)
          .show(context);
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
      LoggingService.exception(e, s,
          context: logContext, transaction: transaction);
      NotificationService.getFlushbar(
              message: LocaleKeys.errorChangeLanguage.tr(),
              color: ColorPalette.warning)
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
                          height: 45.h,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: bodyChildPadding,
                                right: bodyChildPadding,
                                top: 4.h),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.language),
                                      SizedBox(width: Adaptive.w(1)),
                                      Text(
                                        LocaleKeys.dropdownLabelLanguage.tr(),
                                        style: Font.containerText,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: Device.orientation ==
                                              Orientation.portrait
                                          ? 1.h
                                          : 2.h),
                                  loadLanguagesDropdown(),
                                  SizedBox(
                                      height: Device.orientation ==
                                              Orientation.portrait
                                          ? 4.h
                                          : 8.h),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_month_outlined),
                                      SizedBox(width: Adaptive.w(1.5)),
                                      Text(
                                        LocaleKeys.dropdownLabelDay.tr(),
                                        style: Font.containerText,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: Device.orientation ==
                                              Orientation.portrait
                                          ? 1.h
                                          : 2.h),
                                  loadWeekDaysDropdown(),
                                  SizedBox(
                                      height: Device.orientation ==
                                              Orientation.portrait
                                          ? 2.h
                                          : 4.h),
                                  Row(
                                    children: [
                                      Icon(Icons.build_circle_outlined,
                                          size: 22.sp),
                                      SizedBox(width: Adaptive.w(1)),
                                      Text(
                                        'Include Mysteres', // TODO: Get appropriate label
                                        style: Font.containerText,
                                      ),
                                      SizedBox(
                                          width: Device.orientation ==
                                                  Orientation.portrait
                                              ? 4.5.w
                                              : 40.w),
                                      loadRosaryTypeSwitch()
                                    ],
                                  ),
                                ],
                              ),
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
                                  if (_rosaryConfigService.selectedWeekDay ==
                                      null) {
                                    // TODO: Display an appropriate message
                                    return;
                                  }

                                  LandingScreen.checkPage = true;
                                  if (interstitial.isAdLoaded == true) {
                                    interstitial.showInterstitialAd();
                                  }
                                  loadPrayScreen(context);
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

  Widget loadRosaryTypeSwitch() {
    return SizedBox(
      width: Device.orientation == Orientation.portrait ? 25.w : 15.w,
      height: Device.orientation == Orientation.portrait ? 11.h : 23.5.h,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          value: allPrayerType,
          onChanged: (value) {
            setState(() {
              allPrayerType = value;
            });
          },
          activeTrackColor: ColorPalette.primaryDark,
          activeColor: ColorPalette.primaryDark,
          inactiveTrackColor: ColorPalette.primary,
          inactiveThumbColor: ColorPalette.secondaryDark,
        ),
      ),
    );
  }

  void loadPrayScreen(BuildContext context) {
    List<PrayerType> prayerTypes = allPrayerType == true
        ? [PrayerType.normal, PrayerType.mystere]
        : [PrayerType.normal];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PrayScreen(
                  rosaryConfig: RosaryConfig(
                      day: _rosaryConfigService.selectedWeekDay!,
                      language: _rosaryConfigService.selectedLanguage,
                      prayerTypes: prayerTypes),
                )));
  }
}
