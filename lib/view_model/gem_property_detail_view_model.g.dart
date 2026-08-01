// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_property_detail_view_model.dart';

mixin _GemPropertyDetailViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final enchantIdController = registerController(IntFieldController());
  late final maxCountInvController = registerController(IntFieldController());
  late final maxCountItemController = registerController(IntFieldController());
  late final typeController = registerController(
    SelectFieldController<int>(fallback: 0),
  );

  void _afterApplyCandidate(GemPropertyEntity gemProperty) {}

  void _applyCandidate(GemPropertyEntity gemProperty) {
    idController.init(gemProperty.id);
    enchantIdController.init(gemProperty.enchantId);
    maxCountInvController.init(gemProperty.maxCountInv);
    maxCountItemController.init(gemProperty.maxCountItem);
    typeController.init(gemProperty.type);
    _afterApplyCandidate(gemProperty);
  }

  GemPropertyEntity _collectCandidate() {
    return GemPropertyEntity(
      id: idController.collect(),
      enchantId: enchantIdController.collect(),
      maxCountInv: maxCountInvController.collect(),
      maxCountItem: maxCountItemController.collect(),
      type: typeController.collect(),
    );
  }
}
