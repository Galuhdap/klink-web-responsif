import 'package:hive/hive.dart';

class PreferencesUtils {
  static const HIVE_BOX = "IPJBox";
  static const HIVE_AUTH = "UserAuth";
  static const HIVE_AUTH_TOKEN = "AuthToken";
  static const HIVE_SETTING_ENUMERATOR = "SettingEnumerator";

  // Note: User Data
  static Future<void> addUser(String data) async {
    var box = await Hive.openBox(HIVE_BOX);
    await box.put(HIVE_AUTH, data);
  }

  static Future<String?> getUser() async {
    var box = await Hive.openBox(HIVE_BOX);
    return box.get(HIVE_AUTH);
  }

  static Future<void> deleteUser() async {
    var box = await Hive.openBox(HIVE_BOX);
    return box.delete(HIVE_AUTH);
  }

  // Note: Auth Token
  static Future<void> addAuthToken(String data) async {
    var box = await Hive.openBox(HIVE_BOX);
    await box.put(HIVE_AUTH_TOKEN, data);
  }

  static Future<String?> getAuthToken() async {
    var box = await Hive.openBox(HIVE_BOX);
    return "Bearer " + box.get(HIVE_AUTH_TOKEN);
  }

  static Future<void> deleteAuthToken() async {
    var box = await Hive.openBox(HIVE_BOX);
    return box.delete(HIVE_AUTH_TOKEN);
  }

  // Note: Setting Enumerator
  // static Future<void> addSettingEnumerator(
  //     List<SettingEnumeratorResponse?>? data) async {
  //   var box = await Hive.openBox(HIVE_BOX);
  //   List<String>? jsonData = data?.map((e) => jsonEncode(e?.toJson())).toList();
  //   await box.put(HIVE_SETTING_ENUMERATOR, jsonData ?? []);
  // }

  // static Future<List<SettingEnumeratorResponse?>?>
  //     getSettingEnumerator() async {
  //   var box = await Hive.openBox(HIVE_BOX);
  //   var result = box.get(HIVE_SETTING_ENUMERATOR);
  //   if (result is List<String>) {
  //     return result.map((e) {
  //       final jsonMap = jsonDecode(e) as Map<String, dynamic>;
  //       return SettingEnumeratorResponse.fromJson(jsonMap);
  //     }).toList();
  //   } else {
  //     return null;
  //   }
  // }

  // static Future<void> deleteSettingEnumerator() async {
  //   var box = await Hive.openBox(HIVE_BOX);
  //   return box.delete(HIVE_SETTING_ENUMERATOR);
  // }
}
