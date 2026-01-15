import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
    static const String _authBox = 'auth_box';

    static Future<void> init() async {
    await Hive.openBox(_authBox);
  }

  
}