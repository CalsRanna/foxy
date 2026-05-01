class CurrencyTypeFilterEntity {
  final String id;
  final String name;

  const CurrencyTypeFilterEntity({this.id = '', this.name = ''});

  factory CurrencyTypeFilterEntity.fromJson(Map<String, dynamic> json) {
    return CurrencyTypeFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
