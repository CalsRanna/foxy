/// Repository-facing locale query preference.
///
/// This query preference keeps repositories independent from page
/// ViewModels while preserving the bootstrap-selected locale join behavior.
final class LocaleQuerySettings {
  bool localeEnabled = true;

  void reset() {
    localeEnabled = true;
  }

  void update({required bool localeEnabled}) {
    this.localeEnabled = localeEnabled;
  }
}
