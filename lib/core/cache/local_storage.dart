import 'dart:convert';

import 'package:movies/core/cache/shared_prefs_keys.dart';
import 'package:movies/core/cache/shared_prefs_utils.dart';


class LocalStorage {
  LocalStorage._();

  static final LocalStorage _instance = LocalStorage._();

  static LocalStorage get instance => _instance;

  bool get onboarding =>
      SharedPrefsUtils.getData<bool>(key: SharedPrefsKeys.onBoardingKey) ??
          true;

  Future<void> setOnboardingDone() => SharedPrefsUtils.saveData(
    key: SharedPrefsKeys.onBoardingKey,
    value: false,
  );

  // String get appTheme =>
  //     SharedPrefsUtils.getData<String>(key: SharedPrefsKeys.appThemeKey) ??
  //         AppThemeProvider.lightThemeKey;

  Future<void> setTheme(String value) =>
      SharedPrefsUtils.saveData(key: SharedPrefsKeys.appThemeKey, value: value);

  // String? get token =>
  //     SharedPrefsUtils.getData<String>(key: SharedPrefsKeys.tokenKey);
  //
  // Future<void> saveToken(String token) =>
  //     SharedPrefsUtils.saveData(key: SharedPrefsKeys.tokenKey, value: token);
  //
  // Future<void> clearToken() =>
  //     SharedPrefsUtils.removeData(key: SharedPrefsKeys.tokenKey);
  //
  // Future<void> saveUser(MyUser user) async {
  //   await SharedPrefsUtils.saveData(
  //     key: SharedPrefsKeys.userKey,
  //     value: jsonEncode(user.toFirestore()),
  //   );
  // }
  //
  // MyUser? getUser() {
  //   final data = SharedPrefsUtils.getData<String>(key: SharedPrefsKeys.userKey);
  //   if (data == null) return null;
  //   return MyUser.fromFirestore(jsonDecode(data.toString()));
  // }
  //
  // Future<void> clearUser() =>
  //     SharedPrefsUtils.removeData(key: SharedPrefsKeys.userKey);
}
