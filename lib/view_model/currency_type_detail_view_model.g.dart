// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_type_detail_view_model.dart';

mixin _CurrencyTypeDetailViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final itemIdController = registerController(IntFieldController());
  late final categoryIdController = registerController(IntFieldController());
  late final bitIndexController = registerController(IntFieldController());

  CurrencyTypeEntity _collectCandidate() {
    return CurrencyTypeEntity(
      id: idController.collect(),
      itemId: itemIdController.collect(),
      categoryId: categoryIdController.collect(),
      bitIndex: bitIndexController.collect(),
    );
  }

  void _applyCandidate(CurrencyTypeEntity currencyType) {
    idController.init(currencyType.id);
    itemIdController.init(currencyType.itemId);
    categoryIdController.init(currencyType.categoryId);
    bitIndexController.init(currencyType.bitIndex);
    _afterApplyCandidate(currencyType);
  }

  void _afterApplyCandidate(CurrencyTypeEntity currencyType) {}
}
