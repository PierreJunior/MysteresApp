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
  late final RosaryPrayerService _rosaryPrayerService =
      RosaryPrayerService(widget.selectedDay);
  late Map<String, Object> _selectedPrayer;
  bool _isVisible = false;

  // _PrayScreenState(String selectedDay) {
  //   _rosaryPrayerService = RosaryPrayerService(selectedDay);
  // }

  @override
  void initState() {
    super.initState();
    initPrayer();
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

  void nextStep() {
    _rosaryPrayerService.increaseStep();
  }

  void previousStep() {
    _rosaryPrayerService.decreaseStep();
  }

  bool lastStep() {
    if (_rosaryPrayerService.getCurrentStep() == 30) {
      return true;
    } else {
      return false;
    }
  }

  void getPrayer() {
    setState(() {
      _selectedPrayer = _rosaryPrayerService.getPrayer();
    });
  }

  void notificationPrayer() {
    Flushbar(
      backgroundColor: ColorPalette.secondaryDark,
      message: 'Prayer Finished!',
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  void notificationEndedEarly() {
    Flushbar(
      backgroundColor: ColorPalette.primaryWarning,
      message: 'You ended your Rosary early',
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  void initPrayer() {
    setState(() {
      _selectedPrayer = _rosaryPrayerService.getPrayer();
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
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "NotoSansJP Bold",
                        fontSize: 15,
                      ),
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
                        notificationEndedEarly();
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
                      if (_rosaryPrayerService.getCurrentStep() >=
                          _rosaryPrayerService.getTotalPrayerSteps()) {
                        Navigator.popAndPushNamed(context, LandingScreen.id);
                        notificationPrayer();
                      } else {
                        showButton();
                        nextStep();
                        getPrayer();
                        //   Icons.arrow_forward,
                        // color: Colors.white,
                        // size: 40,
                      }
                    },
                    child: Icon(
                      (lastStep()) ? Icons.check : Icons.arrow_forward,
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
