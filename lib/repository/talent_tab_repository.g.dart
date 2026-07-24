// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_tab_repository.dart';

final class TalentTabFilter {
  final String id;
  final String name;

  const TalentTabFilter({this.id = '', this.name = ''});

  factory TalentTabFilter.fromJson(Map<String, dynamic> json) {
    return TalentTabFilter(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  TalentTabFilter copyWith({String? id, String? name}) {
    return TalentTabFilter(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
