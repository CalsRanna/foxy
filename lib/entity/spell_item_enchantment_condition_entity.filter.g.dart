// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class SpellItemEnchantmentConditionFilterEntity {
  final String id;

  const SpellItemEnchantmentConditionFilterEntity({this.id = ''});

  factory SpellItemEnchantmentConditionFilterEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return SpellItemEnchantmentConditionFilterEntity(
      id: json['id']?.toString() ?? '',
    );
  }

  SpellItemEnchantmentConditionFilterEntity copyWith({String? id}) {
    return SpellItemEnchantmentConditionFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
