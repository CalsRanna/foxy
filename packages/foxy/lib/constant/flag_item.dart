/// An individual bit displayable by the Flags picker.
class FlagItem {
  final int value;
  final String label;
  final String? group;

  const FlagItem(this.value, this.label, [this.group]);
}

/// 将位掩码展开为命中的 flag 标签列表，如 `人类, 兽人`。
///
/// 没有命中任何 flag 时回退为原始掩码值，保证信息不丢失。
String flagMaskLabel(int mask, List<FlagItem> flags) {
  final names = flags.where((f) => (mask & f.value) != 0).map((f) => f.label);
  return names.isEmpty ? mask.toString() : names.join(', ');
}
