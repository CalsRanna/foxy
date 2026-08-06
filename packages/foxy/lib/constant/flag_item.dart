/// An individual bit displayable by the Flags picker.
class FlagItem {
  final int value;
  final String label;
  final String? group;

  const FlagItem(this.value, this.label, [this.group]);
}
