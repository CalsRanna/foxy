// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'reference_loot_template_entity.dart';

final class ReferenceLootTemplateKey {
  final int entry;
  final int item;

  const ReferenceLootTemplateKey({required this.entry, required this.item});

  factory ReferenceLootTemplateKey.fromEntity(
    ReferenceLootTemplateEntity entity,
  ) {
    return ReferenceLootTemplateKey(entry: entity.entry, item: entity.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ReferenceLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hashAll([entry, item]);

  @override
  String toString() {
    return 'ReferenceLootTemplateKey('
        'entry: $entry, '
        'item: $item'
        ')';
  }
}
