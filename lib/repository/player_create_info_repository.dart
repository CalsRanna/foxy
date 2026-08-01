import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_repository.g.dart';

@FoxyRepository(PlayerCreateInfoEntity)
@FoxyFilter.text('race')
@FoxyFilter.text('class_')
class PlayerCreateInfoRepository
    with RepositoryMixin, _PlayerCreateInfoRepositoryMixin {
  // 生成版查询层内联表名字面量（mixin 无法访问类静态成员），此处仅作契约校验。
  // ignore: unused_field
  static const _table = 'playercreateinfo';

  @override
  Future<PlayerCreateInfoKey> copyPlayerCreateInfo(PlayerCreateInfoKey key) {
    throw UnsupportedError('出生信息使用种族/职业语义主键，请新增有效组合。');
  }

  @override
  Future<PlayerCreateInfoEntity> createPlayerCreateInfo() async {
    return const PlayerCreateInfoEntity();
  }
}
