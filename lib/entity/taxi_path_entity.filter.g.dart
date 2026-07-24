// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class TaxiPathFilterEntity {
  final String id;

  const TaxiPathFilterEntity({this.id = ''});

  factory TaxiPathFilterEntity.fromJson(Map<String, dynamic> json) {
    return TaxiPathFilterEntity(id: json['id']?.toString() ?? '');
  }

  TaxiPathFilterEntity copyWith({String? id}) {
    return TaxiPathFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
