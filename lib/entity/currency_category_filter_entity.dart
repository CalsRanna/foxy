class CurrencyCategoryFilterEntity {
  final String id;
  final String name;

  const CurrencyCategoryFilterEntity({this.id = '', this.name = ''});

  factory CurrencyCategoryFilterEntity.fromJson(Map<String, dynamic> json) {
    return CurrencyCategoryFilterEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  CurrencyCategoryFilterEntity copyWith({String? id, String? name}) {
    return CurrencyCategoryFilterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
