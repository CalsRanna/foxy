// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_repository.dart';

mixin _CreatureTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyCreatureTemplate(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('creature_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<CreatureTemplateEntity?> getCreatureTemplate(int key) async {
    final results = await _whereKey(
      laconic.table('creature_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureTemplateEntity.fromJson(results.first.toMap());
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('entry', key);
  }
}

final class CreatureTemplateFilter {
  final String entry;
  final String name;
  final String subName;

  const CreatureTemplateFilter({
    this.entry = '',
    this.name = '',
    this.subName = '',
  });

  factory CreatureTemplateFilter.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateFilter(
      entry: json['entry']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      subName: json['subName']?.toString() ?? '',
    );
  }

  CreatureTemplateFilter copyWith({
    String? entry,
    String? name,
    String? subName,
  }) {
    return CreatureTemplateFilter(
      entry: entry ?? this.entry,
      name: name ?? this.name,
      subName: subName ?? this.subName,
    );
  }

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'name': name, 'subName': subName};
  }
}
