import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'player_create_info_repository.g.dart';

@FoxyRepository()
@FoxyFilter.text('race')
@FoxyFilter.text('class_')
class PlayerCreateInfoRepository
    with RepositoryMixin, _PlayerCreateInfoRepositoryMixin {
  // The generated query layer inlines the table-name literal (mixins cannot
  // access class statics); this only serves as a contract check.
  // ignore: unused_field
  static const _table = 'playercreateinfo';

  @override
  Future<PlayerCreateInfoKey> copyPlayerCreateInfo(PlayerCreateInfoKey key) {
    throw CopyNotSupportedException(
      'player create info uses race/class semantic keys; add a valid combination',
    );
  }

  @override
  Future<PlayerCreateInfoEntity> createPlayerCreateInfo() async {
    return const PlayerCreateInfoEntity();
  }
}
