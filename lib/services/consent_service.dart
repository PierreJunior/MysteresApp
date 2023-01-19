

 import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ConsentService{
  ConsentService(bool consentGiven){
    params = ConsentRequestParameters();
    _consentGiven = consentGiven ;
    _initConsent();
  }
  late bool _consentGiven;
  late final ConsentRequestParameters params;


  void _initConsent() async{
     ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
       if( await ConsentInformation.instance.isConsentFormAvailable()){
         ConsentInformation.instance.getConsentStatus();
         loadForm();
       }
     }, (error) {
       // Handle the error
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
       }
       if(status == ConsentStatus.unknown){
         print('WHO KNOWS');
       }
     }, (formError) {
       //Handle the error
       if (kDebugMode) {
         print('form error');
       }
     });
   }

   bool consentIS() => _consentGiven;

 }