// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_immunity_repository.dart';

final class CreatureImmunityFilter {
  final String id;
  final String comment;

  const CreatureImmunityFilter({this.id = '', this.comment = ''});

  factory CreatureImmunityFilter.fromJson(Map<String, dynamic> json) {
    return CreatureImmunityFilter(
      id: json['id']?.toString() ?? '',
      comment: json['comment']?.toString() ?? '',
    );
  }

  CreatureImmunityFilter copyWith({String? id, String? comment}) {
    return CreatureImmunityFilter(
      id: id ?? this.id,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'comment': comment};
  }
}
