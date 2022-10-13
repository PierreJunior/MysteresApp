import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/services/rosary_prayer_service.dart';

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

  // _PrayScreenState(String selectedDay) {
  //   _rosaryPrayerService = RosaryPrayerService(selectedDay);
  // }

  @override
  void initState() {
    super.initState();
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
                        color: Colors.white,
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
                  TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            const CircleBorder()),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorPalette.secondaryDark)),
                    onPressed: () {
                      if (_rosaryPrayerService.getCurrentStep() <= 1) {
                        null;
                      } else {
                        previousStep();
                        getPrayer();
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              const CircleBorder()),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorPalette.secondaryDark)),
                      onPressed: () {
                        if (_rosaryPrayerService.getCurrentStep() >=
                            _rosaryPrayerService.getTotalPrayerSteps()) {
                          var snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: 'Finished',
                              message: '',
                              contentType: ContentType.success,
                              color: Colors.cyan,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          nextStep();
                          getPrayer();
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 40,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
