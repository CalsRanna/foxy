import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/game_object_template_entity.dart';

void main() {
  test('游戏对象类型映射为标签，未知值回退', () {
    expect(const BriefGameObjectTemplateEntity(type: 2).typeLabel, '任务发放者');
    expect(const BriefGameObjectTemplateEntity(type: 99).typeLabel, '99');
  });
}
