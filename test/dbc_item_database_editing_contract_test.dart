import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/dbc_item_entity.dart';

void main() {
  test('DbcItem Entity 精确覆盖八个标量物理列并 round-trip', () {
    final json = const DbcItemEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'ClassID',
      'SubclassID',
      'Sound_override_subclassID',
      'Material',
      'DisplayInfoID',
      'InventoryType',
      'SheatheType',
    ]);
    expect(DbcItemEntity.fromJson(json).toJson(), json);
  });

  test('Brief key 返回物理 ID 标量', () {
    const first = 51;
    expect((const DbcItemEntity(id: 51)).id, first);
    expect(const BriefDbcItemEntity(id: 51).key, first);
  });
}
