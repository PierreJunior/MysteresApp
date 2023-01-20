import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/services/logging_service.dart';


class ConsentService{
  late bool _consentGiven;
  late final ConsentRequestParameters params;

  ConsentService(bool consentGiven){
    params = ConsentRequestParameters();
    _consentGiven = consentGiven ;
    // _initConsent();
  }


  void initConsent() async{
     ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
       if( await ConsentInformation.instance.isConsentFormAvailable()){
         ConsentInformation.instance.getConsentStatus();
         loadForm();
       }
     }, (error) {
       // Handle the error
       LoggingService.message("${error.message} ${error.errorCode}",
           level: LoggingLevel.error);
     });
   }

   void loadForm(){
     ConsentForm.loadConsentForm((consentForm) async{
       var status = await ConsentInformation.instance.getConsentStatus();
       if(status == ConsentStatus.required){
         consentForm.show(
               (formError) {
             loadForm();
           },
         );
       }
       if(status == ConsentStatus.obtained){
         _consentGiven = true;
         // AppLovinMAX.setHasUserConsent(true);
         // AppLovinMAX.setIsAgeRestrictedUser(false);
         // AppLovinMAX.setDoNotSell(false);
         // await AppLovinMAX.initialize(Env.appLovinSDKKey);
       }
       if(status == ConsentStatus.unknown){
         _consentGiven = false;
       }
     }, (error) {
       //Handle the error
       LoggingService.message("${error.message} ${error.errorCode}",
           level: LoggingLevel.error);
     });
   }

   bool consentGiven() => _consentGiven;

 }