import 'package:foxy/entity/currency_type_entity.dart';

class CurrencyTypeKey {
  final int id;

  const CurrencyTypeKey({required this.id});

  factory CurrencyTypeKey.fromEntity(CurrencyTypeEntity entity) =>
      CurrencyTypeKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CurrencyTypeKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
