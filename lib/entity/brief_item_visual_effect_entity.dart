import 'package:foxy/entity/item_visual_effect_key.dart';

class BriefItemVisualEffectEntity {
  final int id;
  final String model;

  const BriefItemVisualEffectEntity({this.id = 0, this.model = ''});

  factory BriefItemVisualEffectEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemVisualEffectEntity(
      id: json['ID'] ?? 0,
      model: json['Model'] ?? '',
    );
  }

  ItemVisualEffectKey get key => ItemVisualEffectKey(id: id);
}
