import 'package:signals/signals.dart';

class FoxyViewModel {
  final hasLocaleTables = signal(false);
  final localeEnabled = signal(false);

  void setLocaleSettings({
    required bool hasLocaleTables,
    required bool localeEnabled,
  }) {
    this.hasLocaleTables.value = hasLocaleTables;
    this.localeEnabled.value = localeEnabled;
  }
}
