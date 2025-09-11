import 'package:foxy/model/version_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class VersionRepository with RepositoryMixin {
  final String _table = 'version';
  Future<void> connect() async {
    await laconic.statement('select version()');
  }

  Future<VersionEntity> getVersion() async {
    var result = await laconic.table(_table).first();
    return VersionEntity.fromJson(result.toMap());
  }
}
