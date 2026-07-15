/// 可由 Flags 选择器展示的独立位。
class FlagItem {
  final int value;
  final String label;
  final String? group;

  const FlagItem(this.value, this.label, [this.group]);
}
