import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/constants.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:mysteres/services/language_service.dart';
import 'package:mysteres/services/logging_service.dart';
import 'package:mysteres/services/notification_service.dart';
import 'package:mysteres/widgets/custom_app_bar.dart';
import 'package:mysteres/widgets/loader.dart';
import 'package:mysteres/widgets/rounded_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mysteres/widgets/error.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  late LanguageService _languageService;
  final String startingLanguage = "English";
  late String selectedLanguage = "--";
  late String title = "";
  bool languageChanged = false;
  bool fetchingDefaults = true;
  bool isFirstScreen = true;
  bool loadingError = false;
  late final LoggingService _log;

  @override
  void initState() {
    super.initState();
    _languageService = LanguageService(FirebaseFirestore.instance);
    _log = LoggingService();
    _initialLoad();
  }

  void _initialLoad() {
    _languageService.loadLanguages().then((value) {
      _languageService.defaultLanguageIsInit().then((value) {
        if (value == 0) {
          setState(() {
            title =
                "Hi there \n\nPlease set your default language to get started.";
          });
        } else {
          setState(() {
            isFirstScreen = false;
            title = "Please set your default language";
          });
        }
        fetchingDefaults = false;
      });
    }).catchError((e, s) {
      _log.exception(e, s);
      setState(() {
        fetchingDefaults = false;
        loadingError = true;
      });
    });
  }

  void _onLanguageChanged(String lang) {
    setState(() {
      languageChanged = true;
      selectedLanguage = lang;
    });
  }

  Future<bool> _setLanguagePref(value) async {
    if (!languageChanged) {
      NotificationService.getFlushbar("Please select a valid language", 2,
              ColorPalette.warning, NotificationPosition.bottom)
          .show(context);
      return false;
    }

    if (selectedLanguage == "--") {
      NotificationService.getFlushbar("Please select a valid language", 2,
              ColorPalette.warning, NotificationPosition.bottom)
          .show(context);
      return false;
    }

    return _languageService.setDefaultLanguage(value);
  }

  Widget loadMainWidget(BuildContext context) {
    while (fetchingDefaults) {
      return const Center(
        child: Loader(),
      );
    }
    return mainWidget(context);
  }

  Widget displayEmoji() {
    if (isFirstScreen) {
      return Text(Emojis.wavingHand, style: TextStyle(fontSize: 30.sp));
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        if (loadingError) {
          return const Error(
            message:
                "An unexpected error occurred. \n\nPlease click on the button below to go to the home page.",
            emoji: Emojis.warning,
          );
        }

        return MaterialApp(
          home: Scaffold(
            appBar: const CustomAppBar(),
            backgroundColor: ColorPalette.primary,
            body: loadMainWidget(context),
          ),
        );
      },
    );
  }

  Center mainWidget(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(bodyChildPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                displayEmoji(),
                Text(
                  title,
                  style: Font.heading1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: Adaptive.h(20),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: bodyChildPadding, right: bodyChildPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            SizedBox(width: 5),
                          ],
                        ),
                        const SizedBox(height: 5),
                        languagesDropdown(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButton(
                        colour: ColorPalette.primaryDark,
                        pressed: () {
                          onConfirmPressed(context);
                        },
                        title: 'Continue'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onConfirmPressed(BuildContext context) {
    _setLanguagePref(selectedLanguage).then((value) {
      if (value == true) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LandingScreen()));
      }
    });
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
        onChanged: (value) {
          _onLanguageChanged(value!);
        },
      ),
    );
  }
}
