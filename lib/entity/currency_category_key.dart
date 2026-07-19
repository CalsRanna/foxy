import 'package:foxy/entity/currency_category_entity.dart';

class CurrencyCategoryKey {
  final int id;

  const CurrencyCategoryKey({required this.id});

  factory CurrencyCategoryKey.fromEntity(CurrencyCategoryEntity entity) =>
      CurrencyCategoryKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CurrencyCategoryKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
