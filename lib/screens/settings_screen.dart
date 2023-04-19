import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/constants.dart';
import 'package:mysteres/global_variable.dart';
import 'package:mysteres/l10n/locale_keys.g.dart';
import 'package:mysteres/navigation_drawer.dart';
import 'package:mysteres/services/consent_service.dart';
import 'package:mysteres/services/language_service.dart';
import 'package:mysteres/services/logging_service.dart';
import 'package:mysteres/services/notification_service.dart';
import 'package:mysteres/widgets/custom_app_bar.dart';

class Settings extends StatefulWidget {
  static bool consentDone = false;
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late LanguageService _languageService;
  final String startingLanguage = "English";
  late String selectedLanguage = "--";
  late String title = "";
  bool languageChanged = false;
  bool fetchingDefaults = true;
  bool isFirstScreen = true;
  bool loadingError = false;
  late final bool consentCheck;
  bool consentGiven = false;
  int x = 0;


  @override
  void initState() {
    super.initState();
    _languageService = LanguageService(FirebaseFirestore.instance);
    _initialLoad();
    consentCheck = ConsentService(consentGiven).updateConsent;
  }

  void _initialLoad() {
    _languageService
        .loadLanguages(languageCodes: GlobalValue.supportedLocales.toList())
        .then((value) {
      _languageService.defaultLanguageIsInit().then((value) {
        if (value == 0) {
          setState(() {
            title =
                "${LocaleKeys.languageSettingsScreenTitleInceptionPrefix.tr()} \n\n${LocaleKeys.languageSettingsScreenTitleInception.tr()}";
          });
        } else {
          setState(() {
            isFirstScreen = false;
            title = LocaleKeys.languageSettingsScreenTitleAfterInception.tr();
          });
        }
        fetchingDefaults = false;
      });
    }).catchError((e, s) {
      LoggingService.exception(e, s);
      setState(() {
        fetchingDefaults = false;
        loadingError = true;
      });
    });
  }

  Future<void> _onLanguageChanged(String lang) async {
    if (lang == "--") {
      NotificationService.getFlushbar(
              message: LocaleKeys.notificationInvalidLanguage.tr(),
              duration: 2,
              color: ColorPalette.warning)
          .show(context);
      return;
    }

    setState(() {
      fetchingDefaults = true;
    });
    await _languageService.getLanguageCode(lang).then((val) async {
      if (val != null) {
        Locale newLocale = Locale(val, null);
        await context.setLocale(newLocale);
        setState(() {
          languageChanged = true;
          selectedLanguage = lang;
          fetchingDefaults = false;
        });
      }
    }).catchError((e, s) {
      LoggingService.exception(e, s);
      setState(() {
        fetchingDefaults = false;
        NotificationService.getFlushbar(
                message: LocaleKeys
                    .errorUnexpectedLanguageSettingsScreenSetDefault
                    .tr(),
                color: ColorPalette.warning)
            .show(context);
      });
    });
  }

  Future<bool> _setLanguagePref(value) async {
    if (!languageChanged) {
      NotificationService.getFlushbar(
          message: LocaleKeys.notificationInvalidLanguage.tr(),
          duration: 2,
          color: ColorPalette.warning)
          .show(context);
      return false;
    }

    if (selectedLanguage == "--") {
      NotificationService.getFlushbar(
          message: LocaleKeys.notificationInvalidLanguage.tr(),
          duration: 2,
          color: ColorPalette.warning)
          .show(context);
      return false;
    }

    return _languageService.setDefaultLanguage(value);
  }

  void updateConsent(BuildContext context) {
    ConsentForm.loadConsentForm((consentForm) async {
      if (Settings.consentDone = true){
        consentForm.show(
              (formError) {
                consentCheck = false;
                updateConsent(context);
          },
        );
      }
    }, (error) {
      //Handle the error
      LoggingService.message("${error.message} ${error.errorCode}",
          level: LoggingLevel.error, transction: 'ConsentService.loadForm');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const NaviDrawer(),
        appBar: const CustomAppBar(),
        backgroundColor: ColorPalette.primary,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(bodyChildPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.pageNameSettings.tr(),
                    style: Font.heading1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: const Divider(
                      color: ColorPalette.primaryDark,
                      thickness: 2,
                    ),
                  ),
                  ExpansionTile(
                    iconColor: ColorPalette.primaryDark,
                    textColor: ColorPalette.primaryDark,
                    leading: const Icon(Icons.language),
                    title: Text(
                      LocaleKeys.dropdownLabelLanguage.tr(),
                      style: Font.containerText,
                    ),
                    children: [
                      languagesDropdown(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip),
                    title: Text(
                      LocaleKeys.btnGetConsent.tr(),
                      style: Font.containerText,
                    ),
                    onTap: () {
                      updateConsent(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget languagesDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        style: const TextStyle(color: Colors.black, fontSize: 20),
        value: selectedLanguage,
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
        items: _languageService.getLanguages(includeEmpty: true).map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Font.containerText,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (value) async {
          await _onLanguageChanged(value!);
          _setLanguagePref(value);
        },
      ),
    );
  }
}
