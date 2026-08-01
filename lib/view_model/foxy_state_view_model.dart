import 'package:foxy/infrastructure/preferences/locale_query_settings.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class FoxyStateViewModel {
  final initialized = signal(false);
  final loading = signal(false);
  final errorMessage = signal<String?>(null);
  final hasLocaleTables = signal(false);
  final localeEnabled = signal(false);

  Future<void> initSignals() async {
    if (initialized.value) return;
    initialized.value = true;
  }

  Future<void> refresh() => initSignals();

  void setLocaleSettings({
    required bool hasLocaleTables,
    required bool localeEnabled,
  }) {
    this.hasLocaleTables.value = hasLocaleTables;
    this.localeEnabled.value = localeEnabled;
    GetIt.instance.get<LocaleQuerySettings>().update(
      localeEnabled: localeEnabled,
    );
    initialized.value = true;
    errorMessage.value = null;
  }

  void dispose() {
    initialized.value = false;
    loading.value = false;
    errorMessage.value = null;
    hasLocaleTables.value = false;
    localeEnabled.value = false;
    if (GetIt.instance.isRegistered<LocaleQuerySettings>()) {
      GetIt.instance.get<LocaleQuerySettings>().reset();
    }
  }
}
