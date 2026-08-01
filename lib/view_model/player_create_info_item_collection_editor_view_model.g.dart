// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_create_info_item_collection_editor_view_model.dart';

mixin _PlayerCreateInfoItemCollectionEditorViewModelMixin
    on FieldControllerMixin {
  late final raceController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final classController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final itemIdController = registerController(IntFieldController());
  late final amountController = registerController(IntFieldController());
  late final noteController = registerController(StringFieldController());

  void _afterApplyCandidate(PlayerCreateInfoItemEntity playerCreateInfoItem) {}

  void _applyCandidate(PlayerCreateInfoItemEntity playerCreateInfoItem) {
    raceController.init(playerCreateInfoItem.race);
    classController.init(playerCreateInfoItem.class_);
    itemIdController.init(playerCreateInfoItem.itemId);
    amountController.init(playerCreateInfoItem.amount);
    noteController.init(playerCreateInfoItem.note);
    _afterApplyCandidate(playerCreateInfoItem);
  }

  PlayerCreateInfoItemEntity _collectCandidate() {
    return PlayerCreateInfoItemEntity(
      race: raceController.collect(),
      class_: classController.collect(),
      itemId: itemIdController.collect(),
      amount: amountController.collect(),
      note: noteController.collect(),
    );
  }
}
