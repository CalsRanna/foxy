/// Repository-facing locale query preference.
///
/// This infrastructure state keeps repositories independent from page
/// ViewModels while preserving the bootstrap-selected locale join behavior.
final class LocaleQuerySettings {
  bool localeEnabled = true;

  void update({required bool localeEnabled}) {
    this.localeEnabled = localeEnabled;
  }

  void reset() {
    localeEnabled = true;
  }
}
