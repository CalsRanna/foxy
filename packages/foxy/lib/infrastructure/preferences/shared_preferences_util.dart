import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static final instance = SharedPreferencesUtil._();

  /// Fetched via [SharedPreferences.getInstance] each time: the instance is
  /// cached inside the package, and tests can re-read mock data after
  /// `resetStatic`.
  Future<SharedPreferences> get _preferences => SharedPreferences.getInstance();

  final _keyWindowHeight = 'window_height';
  final _keyWindowWidth = 'window_width';
  final _keyLastUpdateCheckAt = 'last_update_check_at';

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

  /// Timestamp of the last automatic update check (for the startup
  /// throttle, once per 24h).
  Future<DateTime?> getLastUpdateCheckAt() async {
    final raw = (await _preferences).getString(_keyLastUpdateCheckAt);
    if (raw == null) return null;
    return DateTime.tryParse(raw);
  }

  Future<void> setLastUpdateCheckAt(DateTime time) async {
    await (await _preferences)
        .setString(_keyLastUpdateCheckAt, time.toIso8601String());
  }
}
