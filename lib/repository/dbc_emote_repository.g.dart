// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dbc_emote_repository.dart';

final class DbcEmoteFilter {
  final String id;
  final String command;

  const DbcEmoteFilter({this.id = '', this.command = ''});

  factory DbcEmoteFilter.fromJson(Map<String, dynamic> json) {
    return DbcEmoteFilter(
      id: json['id']?.toString() ?? '',
      command: json['command']?.toString() ?? '',
    );
  }

  DbcEmoteFilter copyWith({String? id, String? command}) {
    return DbcEmoteFilter(id: id ?? this.id, command: command ?? this.command);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'command': command};
  }
}
