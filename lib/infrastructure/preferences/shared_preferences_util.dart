import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static final instance = SharedPreferencesUtil._();

  final _preferences = SharedPreferences.getInstance();

  final _keyWindowHeight = 'window_height';
  final _keyWindowWidth = 'window_width';

  SharedPreferencesUtil._();

  Future<double> getWindowHeight() async {
    return (await _preferences).getDouble(_keyWindowHeight) ?? 750.0;
  }

  Future<double> getWindowWidth() async {
    return (await _preferences).getDouble(_keyWindowWidth) ?? 1000.0;
  }

  Future<void> setWindowHeight(double height) async {
    await (await _preferences).setDouble(_keyWindowHeight, height);
  }

  Future<void> setWindowWidth(double width) async {
    await (await _preferences).setDouble(_keyWindowWidth, width);
  }
}
