import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/services/logging_service.dart';
import 'package:mysteres/screens/language_settings_screen.dart';

class ConsentService {
  late bool _consentGiven;
  late final ConsentRequestParameters params;

  ConsentService(bool consentGiven) {
    params = ConsentRequestParameters();
    _consentGiven = consentGiven;
  }

  void initConsent() async {
    ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
      if (await ConsentInformation.instance.isConsentFormAvailable()) {
        ConsentInformation.instance.getConsentStatus();
        loadForm();
      }
    }, (error) {
      LoggingService.message("${error.message} ${error.errorCode}",
          level: LoggingLevel.error, transction: 'ConsentService.initConsent');
    });
  }

  void loadForm() {
    ConsentForm.loadConsentForm((consentForm) async {
      ConsentStatus status =
          await ConsentInformation.instance.getConsentStatus();
      if (status == ConsentStatus.required) {
        consentForm.show(
          (formError) {
            loadForm();
          },
        );
      }
      if( LanguageSettings.settings == true){
        LanguageSettings.settings = false;
        consentForm.show(
              (formError) {
            loadForm();
          },
        );
      }
      if (status == ConsentStatus.obtained) {
        // MyMethodChannel platform = MyMethodChannel();
        _consentGiven = true;
        // await platform.setAppLovinIsAgeRestrictedUser(true);
        // await platform.setHasUserConsent(_consentGiven);
      }
      if (status == ConsentStatus.unknown) {
        _consentGiven = false;
      }
    }, (error) {
      //Handle the error
      LoggingService.message("${error.message} ${error.errorCode}",
          level: LoggingLevel.error, transction: 'ConsentService.loadForm');
    });
  }

  bool consentGiven() => _consentGiven;
}
