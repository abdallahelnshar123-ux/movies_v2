import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  static late SharedPreferences sharedPreferences;

  static Future<SharedPreferences> init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    switch (value) {
      case int _:
        return await sharedPreferences.setInt(key, value);
      case String _:
        return await sharedPreferences.setString(key, value);
      case double _:
        return await sharedPreferences.setDouble(key, value);
      case List<String> _:
        return await sharedPreferences.setStringList(key, value);
      case bool _:
        return await sharedPreferences.setBool(key, value);
      default:
        throw UnsupportedError('Unsupported type ${value.runtimeType}');
    }
  }

  static T? getData<T>({required String key}) {
    final value = sharedPreferences.get(key);

    if (value is T) return value;

    return null;
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
