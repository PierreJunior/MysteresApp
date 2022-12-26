import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysteres/services/rosary_config_service.dart';
import 'mock.dart';

void main() async {
  setupSharedPreferencesMock();
  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  group("Default language not set", () {
    test("Throw exception when no default language is found", () async {
      RosaryConfigService service = RosaryConfigService();
      expect(() => service.init(), throwsException);
    });
  });
}
