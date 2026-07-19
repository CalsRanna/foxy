import 'package:foxy/entity/item_template_entity.dart';

class ItemTemplateKey {
  final int entry;

  const ItemTemplateKey({required this.entry});

  factory ItemTemplateKey.fromEntity(ItemTemplateEntity entity) {
    return ItemTemplateKey(entry: entity.entry);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemTemplateKey && other.entry == entry;

  @override
  int get hashCode => entry.hashCode;
}
