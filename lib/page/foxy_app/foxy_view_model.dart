class FoxyViewModel {
  bool hasLocaleTables = false;
  bool localeEnabled = false;

  void setLocaleSettings({
    required bool hasLocaleTables,
    required bool localeEnabled,
  }) {
    this.hasLocaleTables = hasLocaleTables;
    this.localeEnabled = localeEnabled;
  }
}
