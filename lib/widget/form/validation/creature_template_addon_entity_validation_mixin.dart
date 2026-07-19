import 'package:foxy/entity/creature_template_addon_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CreatureTemplateAddonValidationMixin on ViewModelValidationMixin {
  void validateCreatureTemplateAddonFields(CreatureTemplateAddonEntity value) {
    if (value.entry <= 0) throw ArgumentError('生物模板编号必须大于 0');
    if (value.visibilityDistanceType < 0 || value.visibilityDistanceType > 5) {
      throw RangeError.range(
        value.visibilityDistanceType,
        0,
        5,
        'visibilityDistanceType',
      );
    }
    normalizeCreatureTemplateAddonAuras(value.auras);
  }
}

String normalizeCreatureTemplateAddonAuras(String value) {
  final tokens = value.trim().isEmpty
      ? const <String>[]
      : value.trim().split(RegExp(r'\s+'));
  final spellIds = <int>[];
  final seen = <int>{};
  for (final token in tokens) {
    final spellId = int.tryParse(token);
    if (spellId == null || spellId <= 0) {
      throw FormatException('光环列表只能包含以空格分隔的正整数法术 ID');
    }
    if (!seen.add(spellId)) {
      throw FormatException('光环列表不能包含重复法术 ID: $spellId');
    }
    spellIds.add(spellId);
  }
  return spellIds.join(' ');
}
