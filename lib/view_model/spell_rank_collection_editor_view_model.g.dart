// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spell_rank_collection_editor_view_model.dart';

mixin _SpellRankCollectionEditorViewModelMixin on FieldControllerMixin {
  late final firstSpellIdController = registerController(IntFieldController());
  late final spellIdController = registerController(IntFieldController());
  late final rankController = registerController(IntFieldController());

  SpellRankEntity _collectCandidate() {
    return SpellRankEntity(
      firstSpellId: firstSpellIdController.collect(),
      spellId: spellIdController.collect(),
      rank: rankController.collect(),
    );
  }

  void _applyCandidate(SpellRankEntity spellRank) {
    firstSpellIdController.init(spellRank.firstSpellId);
    spellIdController.init(spellRank.spellId);
    rankController.init(spellRank.rank);
    _afterApplyCandidate(spellRank);
  }

  void _afterApplyCandidate(SpellRankEntity spellRank) {}
}
