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

  List<Widget> titleSectionChildren() {
    return [title(), subTitle(), divider()];
  }

  Widget divider() {
    return const SizedBox(
      height: 20,
      width: 150.0,
      child: Divider(
        color: ColorPalette.primaryDark,
        thickness: 2,
      ),
    );
  }

  Widget title() {
    int repeat = _selectedPrayer["repeat"] as int? ?? 1;
    String title = _selectedPrayer["title"] as String? ?? "";
    if (repeat > 1) {
      title += " (x$repeat)";
    }

    return Text(
      title,
      style: Font.heading1,
      textAlign: TextAlign.center,
    );
  }

  Widget subTitle() {
    if (_selectedPrayer["type"] == "mystere") {
      String mystere = _selectedPrayer["mystere"] as String? ?? "";
      String count = _selectedPrayer["count"] as String? ?? "";
      return Text("$count $mystere", style: Font.heading3);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget stopButton() {
    return ElevatedButton(
        style: ButtonStyle(
            shape:
                MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorPalette.primaryDark)),
        onPressed: () {
          Navigator.popAndPushNamed(context, LandingScreen.id);
          if (!_rosaryPrayerService.isLastStep()) {
            showNotification(
                "You ended your Rosary early", 5, ColorPalette.primaryWarning);
          }
        },
        child: const Icon(
          Icons.stop,
          color: ColorPalette.primary,
          size: 50,
        ));
  }

  Widget nextStepButton() {
    return ElevatedButton(
      style: ButtonStyle(
          shape:
              MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorPalette.secondaryDark)),
      onPressed: () {
        if (_rosaryPrayerService.isLastStep()) {
          Navigator.popAndPushNamed(context, LandingScreen.id);
          showNotification("Prayer finished!", 5, ColorPalette.secondaryDark);
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
    );
  }

  Widget previousStepButton() {
    return Visibility(
      visible: _isVisible,
      child: ElevatedButton(
        style: ButtonStyle(
            shape:
                MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorPalette.secondaryDark)),
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
    );
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: titleSectionChildren(),
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
                  Column(
                    children: [previousStepButton()],
                  ),
                  Column(
                    children: [stopButton()],
                  ),
                  Column(
                    children: [nextStepButton()],
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
