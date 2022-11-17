import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:mysteres/services/rosary_config_service.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/color_palette.dart';
import '../components/font.dart';
import '../constants.dart';
import '../widgets/ads.dart';
import '../widgets/rounded_button.dart';

class LanguageSettings extends StatefulWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  String getSavedLanguage() {
    _LanguageSettingsState().getData();
    return _LanguageSettingsState().savedLanguage;
  }

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  late RosaryConfigService _rosaryConfigService;
  late String valueLanguage = "English";
  late String savedLanguage = "";
  late bool changed;
  late String sharedPreferenceKey = "";

  @override
  void initState() {
    super.initState();
    changed = false;
    _rosaryConfigService = RosaryConfigService();
    getData();
    widget.getSavedLanguage();
  }

  void onLanguageChanged(String lang) {
    _rosaryConfigService.changeLanguage(lang);
    setState(() {});
  }

  Future<bool> saveData(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(sharedPreferenceKey, value);
  }

  Future getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    savedLanguage = prefs.getString(sharedPreferenceKey)!;
    return savedLanguage;
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
                          'Configure your Language setting',
                          style: Font.heading1,
                          textAlign: TextAlign.start,
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
                                  changed == false
                                      ? saveData(valueLanguage)
                                      : getData();
                                  _rosaryConfigService
                                      .setSelectedLang(valueLanguage);
                                  onLanguageChanged(valueLanguage);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LandingScreen(
                                            valueLanguage: valueLanguage,
                                          )));
                                },
                                title: 'Confirm'),
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

  Widget languagesDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        style: const TextStyle(color: Colors.black, fontSize: 20),
        value: valueLanguage,
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
          changed = true;
          saveData(value!);
          getData();
          onLanguageChanged(value);
          valueLanguage = value;
        },
      ),
    );
  }
}
