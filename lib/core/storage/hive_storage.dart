import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static const String _authBox = 'auth_box';

  static Future<void> init() async {
    await Hive.openBox(_authBox);
  }
  static Box get authBox => Hive.box(_authBox);

  static Future<void> saveAuthToken(String token) async {
    await authBox.put('auth_token', token);
  }
  
}
