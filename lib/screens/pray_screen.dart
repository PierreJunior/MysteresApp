import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/navigation_drawer.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:mysteres/services/logging_service.dart';
import 'package:mysteres/services/rosary_prayer_service.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:mysteres/widgets/container_content.dart';
import 'package:mysteres/widgets/reusable_container.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants.dart';
import '../widgets/ads.dart';
import 'package:text_scroll/text_scroll.dart';

class PrayScreen extends StatefulWidget {
  const PrayScreen(
      {Key? key, required this.selectedDay, required this.selectedLanguage})
      : super(key: key);
  static const String id = "PrayingScreen";
  final String selectedDay;
  final String selectedLanguage;

  @override
  State<PrayScreen> createState() => _PrayScreenState();
}

class _PrayScreenState extends State<PrayScreen> {
  late final RosaryPrayerService _rosaryPrayerService;
  late Map<String, dynamic> _selectedPrayer;
  late final LoggingService _log;
  int module = 0;
  bool isLoadingPrayers = true;
  bool loadingError = false;

  @override
  void initState() {
    super.initState();
    _log = LoggingService();
    _rosaryPrayerService =
        RosaryPrayerService(widget.selectedDay, widget.selectedLanguage);
    _rosaryPrayerService.loadPrayers().then((value) {
      setState(() {
        initPrayer();
        isLoadingPrayers = false;
      });
    }).catchError((e, s) async {
      Map<String, dynamic> context = {
        "selectedDay": widget.selectedDay,
        "selectedLanguage": widget.selectedLanguage
      };
      String transaction = "_PrayScreenState.initState";
      await _log.exception(e, s, context, transaction);
      setState(() {
        showNotification(
            "Error loading prayers", 5, ColorPalette.primaryWarning);
        loadingError = true;
      });
    });
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
    return SizedBox(
      height: 10,
      width: 40.w,
      child: const Divider(
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

    double scrollVelocity = title.length < 30 ? 35 : 70;

    return Padding(
        padding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
        child: TextScroll(
          title,
          numberOfReps: 1,
          velocity: Velocity(pixelsPerSecond: Offset(scrollVelocity, 0)),
          pauseBetween: const Duration(milliseconds: 1000),
          delayBefore: const Duration(milliseconds: 500),
          mode: TextScrollMode.bouncing,
          style: Font.heading1,
          textAlign: TextAlign.center,
        ));
  }

  Widget subTitle() {
    if (_selectedPrayer["type"] == "mystere") {
      String mystere = _selectedPrayer["sub_title"] as String? ?? "";
      String count = _selectedPrayer["count"] as String? ?? "";
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text("$count $mystere", style: Font.heading3),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget stopButton() {
    return ElevatedButton(
        style: stepButtonStyle(StepAction.stop),
        onPressed: () {
          LandingScreen.checkPage = false;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LandingScreen()));
          if (!_rosaryPrayerService.isLastStep()) {
            showNotification(
                "You ended your Rosary early", 5, ColorPalette.primaryWarning);
          }
        },
        child: stepIcon(StepAction.stop));
  }

  Widget errorButton([String? message]) {
    message ??= "Error loading prayers";
    return ElevatedButton(
        style: stepButtonStyle(StepAction.error),
        onPressed: () {
          LandingScreen.checkPage = false;
          Navigator.pop(context, LandingScreen.id);
        },
        child: stepIcon(StepAction.error));
  }

  Widget nextStepButton() {
    return ElevatedButton(
      style: stepButtonStyle(StepAction.next),
      onPressed: () {
        if (_rosaryPrayerService.isLastStep()) {
          Navigator.popAndPushNamed(context, LandingScreen.id);
          showNotification("Prayer finished!", 5, ColorPalette.secondaryDark);
        } else {
          module = _rosaryPrayerService.getCurrentStep() % 2;
          nextStep();
        }
      },
      child: stepIcon(StepAction.next),
    );
  }

  Widget previousStepButton() {
    return ElevatedButton(
      style: stepButtonStyle(StepAction.previous),
      onPressed: () {
        if (!_rosaryPrayerService.isFirstStep()) {
          module = _rosaryPrayerService.getCurrentStep() % 2;
          previousStep();
        }
      },
      child: stepIcon(StepAction.previous),
    );
  }

  ButtonStyle stepButtonStyle(StepAction action) {
    // ElevatedButton.styleFrom(fixedSize: const Size(300, 50));
    Color backgrounColor;
    if (action == StepAction.next || action == StepAction.previous) {
      backgrounColor = ColorPalette.secondaryDark;
    } else if (action == StepAction.stop) {
      backgrounColor = ColorPalette.primaryDark;
    } else if (action == StepAction.error) {
      backgrounColor = ColorPalette.primaryDark;
    } else {
      throw Exception("The provided action is not supported.");
    }

    return ButtonStyle(
        fixedSize:
            MaterialStateProperty.all(Size.fromHeight(actionButtonWidth)),
        shape: MaterialStateProperty.all<OutlinedBorder>(const CircleBorder()),
        backgroundColor: MaterialStateProperty.all<Color>(backgrounColor));
  }

  Icon stepIcon(StepAction action) {
    IconData icon;
    Color color;

    if (action == StepAction.next) {
      icon =
          _rosaryPrayerService.isLastStep() ? Icons.check : Icons.arrow_forward;
      color = Colors.white;
    } else if (action == StepAction.previous) {
      icon = Icons.arrow_back;
      color = Colors.white;
    } else if (action == StepAction.stop) {
      icon = Icons.stop;
      color = ColorPalette.primary;
    } else if (action == StepAction.error) {
      icon = Icons.keyboard_return;
      color = ColorPalette.primary;
    } else {
      throw Exception("The provided action is not supported.");
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
        if (isLoadingPrayers && !loadingError) {
          return const CircularProgressIndicator();
        } else if (isLoadingPrayers && loadingError) {
          return errorBuild();
        } else {
          return Device.orientation == Orientation.portrait
              ? portraitScaffold(scaffoldKey)
              : landscapeScaffold(scaffoldKey);
        }
      },
    );
  }

  Scaffold errorBuild() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ROSARY'),
        backgroundColor: ColorPalette.primaryDark,
      ),
      backgroundColor: ColorPalette.primary,
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Error loading prayers",
            style: Font.heading1,
          ),
        ],
      ))),
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
                unselectedColor: ColorPalette.secondaryDark,
                selectedColor: ColorPalette.primaryDark,
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
      bottomNavigationBar: module == 0
          ? SizedBox(
              height: Adaptive.h(10),
            )
          : const Ads(),
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
                      child: Column(
                    children: [
                      Container(
                        height: 40.h,
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [title(), subTitle(), divider()],
                        ),
                      ),
                      Container(
                        height: 20.h,
                        alignment: Alignment.center,
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              previousStepButton(),
                              stopButton(),
                              nextStepButton(),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: module != 0
          ? SizedBox(
              height: Adaptive.h(10),
            )
          : const Ads(),
    );
  }
}

enum StepAction { previous, stop, next, error }
