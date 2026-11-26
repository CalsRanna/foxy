/// An individual bit displayable by the Flags picker.
class FlagItem {
  final int value;
  final String label;
  final String? group;

  const FlagItem(this.value, this.label, [this.group]);

  /// Lists the labels for the bits set in [mask], such as `Human, Orc`.
  ///
  /// Falls back to the numeric mask when none of [flags] match.
  static String maskLabel(int mask, List<FlagItem> flags) {
    final names = flags.where((f) => (mask & f.value) != 0).map((f) => f.label);
    return names.isEmpty ? mask.toString() : names.join(', ');
  }
}
