import 'package:quizzler/import.dart';

class LocalData {
  static late SharedPreferences sharedPreferences;
  static Future<SharedPreferences> init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static const _isAssistOn = 'Assist';

  static Future setAssist(bool isAssistOn) async =>
      await sharedPreferences.setBool(_isAssistOn, isAssistOn);

  static bool? get getAssist => sharedPreferences.getBool(_isAssistOn);
}
