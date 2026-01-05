import 'package:laconic/laconic.dart';

class FoxyViewModel {
  Laconic? laconic;
  bool hasLocaleTables = false;
  bool localeEnabled = false;

  void initSignals(Laconic laconic) {
    this.laconic = laconic;
  }

  void setLocaleSettings({
    required bool hasLocaleTables,
    required bool localeEnabled,
  }) {
    this.hasLocaleTables = hasLocaleTables;
    this.localeEnabled = localeEnabled;
  }
}
