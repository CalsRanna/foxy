import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin SpellRankValidationMixin on ViewModelValidationMixin {
  void validateSpellRankFields(SpellRankEntity value) {
    final firstSpellId = value.firstSpellId;
    final spellId = value.spellId;
    final rank = value.rank;

    if (firstSpellId <= 0 || spellId <= 0) {
      throw ArgumentError('first_spell_id 和 spell_id 必须大于 0');
    }
    if (rank <= 0 || rank > 255) {
      throw RangeError.range(rank, 1, 255, 'rank');
    }
    if (rank == 1 && firstSpellId != spellId) {
      throw ArgumentError('rank=1 时 first_spell_id 必须等于 spell_id');
    }
  }
}
