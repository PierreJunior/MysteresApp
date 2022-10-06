import 'package:flutter/material.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/services/rosary_prayer_service.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class PrayScreen extends StatefulWidget {
  static const String id = "PrayingScreen";
  const PrayScreen({Key? key}) : super(key: key);

  @override
  State<PrayScreen> createState() => _PrayScreenState();
}

class _PrayScreenState extends State<PrayScreen> {
  late RosaryPrayerService _rosaryPrayerService;
  late Map<String, Object> _selectedPrayer;

  _PrayScreenState() {
    // TODO: Fix this part by passing the selected day to this screen
    _rosaryPrayerService = RosaryPrayerService("monday");
  }

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
        backgroundColor: Colors.white10,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _selectedPrayer["title"] as String? ?? "",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: Text(
                  _selectedPrayer["value"] as String? ?? "",
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      if (_rosaryPrayerService.getCurrentStep() <= 1) {
                        null;
                      } else {
                        previousStep();
                        getPrayer();
                      }
                    },
                    child: const Icon(
                      Icons.navigate_before,
                      color: Colors.grey,
                      size: 100,
                    ),
                  ),
                  TextButton(
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
                        Icons.navigate_next,
                        color: Colors.grey,
                        size: 100,
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
