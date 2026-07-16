class LockFilterEntity {
  final String id;

  const LockFilterEntity({this.id = ''});

  factory LockFilterEntity.fromJson(Map<String, dynamic> json) {
    return LockFilterEntity(id: json['id'] ?? '');
  }

  LockFilterEntity copyWith({String? id}) {
    return LockFilterEntity(id: id ?? this.id);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
