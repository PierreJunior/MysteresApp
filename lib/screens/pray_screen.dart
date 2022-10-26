import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:mysteres/services/rosary_prayer_service.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:mysteres/widgets/container_content.dart';
import 'package:mysteres/widgets/reusable_container.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/ads.dart';

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

  @override
  void initState() {
    super.initState();
    _rosaryPrayerService = RosaryPrayerService(widget.selectedDay);
    initPrayer();
  }

  void nextStep() {
    _rosaryPrayerService.increaseStep();
    getPrayer();
  }

  void previousStep() {
    if (_rosaryPrayerService.isFirstStep()) {
      return;
    }

    _rosaryPrayerService.decreaseStep();
    getPrayer();
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

  void showNotification(String message, int duration, Color color) {
    Flushbar(
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundColor: color,
      message: message,
      duration: Duration(seconds: duration),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  List<Widget> titleSectionChildren() {
    return [title(), subTitle(), divider()];
  }

  Widget divider() {
    return const SizedBox(
      height: 10,
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

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Text(
        title,
        style: Font.heading1,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget titleLandscape() {
    int repeat = _selectedPrayer["repeat"] as int? ?? 1;
    String title = _selectedPrayer["title"] as String? ?? "";
    if (repeat > 1) {
      title += " (x$repeat)";
    }

    return Text(
      title,
      style: Font.heading1Landscape,
      textAlign: TextAlign.center,
    );
  }

  Widget subTitle() {
    if (_selectedPrayer["type"] == "mystere") {
      String mystere = _selectedPrayer["mystere"] as String? ?? "";
      String count = _selectedPrayer["count"] as String? ?? "";
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text("$count $mystere", style: Font.heading3),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget subTitleLandscape() {
    if (_selectedPrayer["type"] == "mystere") {
      String mystere = _selectedPrayer["mystere"] as String? ?? "";
      String count = _selectedPrayer["count"] as String? ?? "";
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text("$count $mystere", style: Font.heading3),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget stopButton() {
    return ElevatedButton(
        style: stepButtonStyle("stop"),
        onPressed: () {
          LandingScreen.checkPage = false;
          Navigator.pop(context, LandingScreen.id);
          if (!_rosaryPrayerService.isLastStep()) {
            showNotification(
                "You ended your Rosary early", 5, ColorPalette.primaryWarning);
          }
        },
        child: stepIcon("stop"));
  }

  Widget nextStepButton() {
    return ElevatedButton(
      style: stepButtonStyle("next"),
      onPressed: () {
        if (_rosaryPrayerService.isLastStep()) {
          Navigator.popAndPushNamed(context, LandingScreen.id);
          showNotification("Prayer finished!", 5, ColorPalette.secondaryDark);
        } else {
          nextStep();
        }
      },
      child: stepIcon("next"),
    );
  }

  Widget previousStepButton() {
    return ElevatedButton(
      style: stepButtonStyle("previous"),
      onPressed: () {
        if (!_rosaryPrayerService.isFirstStep()) {
          previousStep();
        }
      },
      child: stepIcon("previous"),
    );
  }

  ButtonStyle stepButtonStyle(String action) {
    Color backgrounColor;
    if (action == "next" || action == "previous") {
      backgrounColor = ColorPalette.secondaryDark;
    } else if (action == "stop") {
      backgrounColor = ColorPalette.primaryDark;
    } else {
      throw Exception("Invalid value. Value must be next, previous, stop");
    }

    return ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
        backgroundColor: MaterialStateProperty.all<Color>(backgrounColor));
  }

  Icon stepIcon(String action) {
    IconData icon;
    Color color;

    if (action == "next") {
      icon =
          _rosaryPrayerService.isLastStep() ? Icons.check : Icons.arrow_forward;
      color = Colors.white;
    } else if (action == "previous") {
      icon = Icons.arrow_back;
      color = Colors.white;
    } else if (action == "stop") {
      icon = Icons.stop;
      color = ColorPalette.primary;
    } else {
      throw Exception("Invalid value. Value must be next, previous, stop");
    }

    return Icon(
      icon,
      color: color,
      size: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Device.orientation == Orientation.portrait
            ? portraitScaffold(scaffoldKey)
            : landscapeScaffold(scaffoldKey);
      },
    );
  }

  Scaffold portraitScaffold(GlobalKey<ScaffoldState> scaffoldKey) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: const Text('ROSARY'),
        backgroundColor: ColorPalette.primaryDark,
      ),
      backgroundColor: ColorPalette.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              StepProgressIndicator(
                totalSteps: _rosaryPrayerService.getTotalPrayerSteps(),
                size: 7,
                currentStep: _rosaryPrayerService.getCurrentStep(),
                unselectedColor: ColorPalette.primaryDark,
                selectedColor: ColorPalette.secondaryDark,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: titleSectionChildren(),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      previousStepButton(),
                      stopButton(),
                      nextStepButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Ads(),
    );
  }

  Scaffold landscapeScaffold(GlobalKey<ScaffoldState> scaffoldKey) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: const Text('ROSARY'),
        backgroundColor: ColorPalette.primaryDark,
      ),
      backgroundColor: ColorPalette.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(children: [
                      StepProgressIndicator(
                        totalSteps: _rosaryPrayerService.getTotalPrayerSteps(),
                        size: 7,
                        currentStep: _rosaryPrayerService.getCurrentStep(),
                        unselectedColor: ColorPalette.primaryDark,
                        selectedColor: ColorPalette.secondaryDark,
                      ),
                      ReusableCard(
                        colour: Colors.transparent,
                        cardChild: SingleChildScrollView(
                          child: ContainerContent(
                            prayerBody:
                                _selectedPrayer["value"] as String? ?? "",
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Column(children: [
                      title(),
                      subTitle(),
                      divider(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            previousStepButton(),
                            stopButton(),
                            nextStepButton(),
                          ],
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: const Ads(),
    );
  }
}
