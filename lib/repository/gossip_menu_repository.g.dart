// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gossip_menu_repository.dart';

final class GossipMenuFilter {
  final String menuId;
  final String text;

  const GossipMenuFilter({this.menuId = '', this.text = ''});

  factory GossipMenuFilter.fromJson(Map<String, dynamic> json) {
    return GossipMenuFilter(
      menuId: json['menuId']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
    );
  }

  GossipMenuFilter copyWith({String? menuId, String? text}) {
    return GossipMenuFilter(
      menuId: menuId ?? this.menuId,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toJson() {
    return {'menuId': menuId, 'text': text};
  }
}
