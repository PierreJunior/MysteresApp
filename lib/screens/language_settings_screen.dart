import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:mysteres/services/language_service.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/color_palette.dart';
import '../components/font.dart';
import '../constants.dart';
import '../global_variable.dart';
import '../widgets/ads.dart';
import '../widgets/rounded_button.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  late LanguageService _languageService;
  final String startingLanguage = "English";
  late String selectedLanguage = "English";
  late bool languageChanged;
  bool isLoadingLanguages = true;

  @override
  void initState() {
    super.initState();
    languageChanged = false;
    _setLanguagePref(startingLanguage);
    _languageService = LanguageService();
    _initialLoad();
  }

  void _initialLoad() {
    _languageService.loadLanguages().then((value) {
      setState(() {
        isLoadingLanguages = false;
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (languageChanged) {
      prefs.setInt(GlobalValue.sharedPreferenceLanguageSetKey, 1);
    }

    return prefs.setString(
        GlobalValue.sharedPreferenceDefaultLanguageKey, value);
  }

  Future getDefaultLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedLanguage =
        prefs.getString(GlobalValue.sharedPreferenceDefaultLanguageKey)!;
    return selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('ROSARY'),
              backgroundColor: ColorPalette.primaryDark,
            ),
            backgroundColor: ColorPalette.primary,
            body: Center(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(bodyChildPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Welcome! \n\nPlease set your default language',
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
                                left: bodyChildPadding,
                                right: bodyChildPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 5),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                loadLanguagesDropdown(),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButton(
                                colour: ColorPalette.secondaryDark,
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
            ),
            bottomNavigationBar: const Ads(),
          ),
        );
      },
    );
  }

  void onConfirmPressed(BuildContext context) {
    _setLanguagePref(selectedLanguage);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LandingScreen()));
  }

  Widget loadLanguagesDropdown() {
    while (isLoadingLanguages) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return languagesDropdown();
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
        items: _languageService.getLanguages().map((value) {
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