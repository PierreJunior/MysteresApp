import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:mysteres/services/rosary_prayer_service.dart';
import 'package:another_flushbar/flushbar.dart';

class PrayScreen extends StatefulWidget {
  const PrayScreen({Key? key, required this.selectedDay}) : super(key: key);
  static const String id = "PrayingScreen";
  final String selectedDay;

  @override
  State<PrayScreen> createState() => _PrayScreenState();
}

class _PrayScreenState extends State<PrayScreen> {
  late final RosaryPrayerService _rosaryPrayerService;
  late Map<String, Object> _selectedPrayer;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _rosaryPrayerService = RosaryPrayerService(widget.selectedDay);
    initPrayer();
  }

  void nextStep() {
    _rosaryPrayerService.increaseStep();
  }

  void previousStep() {
    _rosaryPrayerService.decreaseStep();
  }

  void getPrayer() {
    setState(() {
      _selectedPrayer = _rosaryPrayerService.getPrayer();
    });
  }

  void initPrayer() {
    setState(() {
      _selectedPrayer = _rosaryPrayerService.getPrayer();
    });
  }

  bool isLastStep() {
    if (_rosaryPrayerService.getCurrentStep() == 30) {
      return true;
    } else {
      return false;
    }
  }

  void showNotification(String message, int duration, Color color) {
    Flushbar(
      backgroundColor: color,
      message: message,
      duration: Duration(seconds: duration),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  void showButton() {
    setState(() {
      _isVisible = true;
    });
  }

  void hideButton() {
    setState(() {
      if (_rosaryPrayerService.getCurrentStep() == 2) {
        _isVisible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryDark,
      ),
      backgroundColor: ColorPalette.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _selectedPrayer["title"] as String? ?? "",
                style: Font.heading1,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _selectedPrayer["count"] as String? ?? "",
                    style: Font.heading3,
                  ),
                  const SizedBox(width: 5),
                  Text(_selectedPrayer["mystere"] as String? ?? "",
                      style: Font.heading3),
                ],
              ),
              const SizedBox(
                height: 20,
                width: 150.0,
                child: Divider(
                  color: ColorPalette.primaryDark,
                  thickness: 2,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _selectedPrayer["value"] as String? ?? "",
                      style: Font.paragraph,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: _isVisible,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              const CircleBorder()),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorPalette.secondaryDark)),
                      onPressed: () {
                        hideButton();
                        previousStep();
                        getPrayer();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              const CircleBorder()),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorPalette.primaryDark)),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, LandingScreen.id);
                        if (!_rosaryPrayerService.isLastStep()) {
                          showNotification("You ended your Rosary early", 5,
                              ColorPalette.primaryWarning);
                        }
                      },
                      child: const Icon(
                        Icons.stop,
                        color: ColorPalette.primary,
                        size: 50,
                      )),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            const CircleBorder()),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorPalette.secondaryDark)),
                    onPressed: () {
                      if (_rosaryPrayerService.isLastStep()) {
                        Navigator.popAndPushNamed(context, LandingScreen.id);
                        showNotification(
                            "Prayer finished!", 5, ColorPalette.secondaryDark);
                      } else {
                        showButton();
                        nextStep();
                        getPrayer();
                      }
                    },
                    child: Icon(
                      (isLastStep()) ? Icons.check : Icons.arrow_forward,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
