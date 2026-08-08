// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_spell_custom_linked_list_view_model.dart';

mixin _PlayerCreateInfoSpellCustomLinkedListViewModelMixin
    on FieldControllerMixin {
  late final raceMaskController = registerController(FlagFieldController());
  late final classMaskController = registerController(FlagFieldController());
  late final spellController = registerController(IntFieldController());
  late final noteController = registerController(StringFieldController());

  void _afterApplyCandidate(
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) {}

  void _applyCandidate(
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) {
    raceMaskController.init(playerCreateInfoSpellCustom.raceMask);
    classMaskController.init(playerCreateInfoSpellCustom.classMask);
    spellController.init(playerCreateInfoSpellCustom.spell);
    noteController.init(playerCreateInfoSpellCustom.note);
    _afterApplyCandidate(playerCreateInfoSpellCustom);
  }

  PlayerCreateInfoSpellCustomEntity _collectCandidate() {
    return PlayerCreateInfoSpellCustomEntity(
      raceMask: raceMaskController.collect(),
      classMask: classMaskController.collect(),
      spell: spellController.collect(),
      note: noteController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    PlayerCreateInfoSpellCustomEntity playerCreateInfoSpellCustom,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'playercreateinfo_spell_custom',
          actionType: action,
          entityName: 'PlayerCreateInfoSpellCustom',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
