import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'scaling_stat_distribution_repository.g.dart';

@FoxyRepository(ScalingStatDistributionEntity)
@FoxyFilter.text('id')
class ScalingStatDistributionRepository
    with RepositoryMixin, _ScalingStatDistributionRepositoryMixin {
  static const _table = 'foxy.dbc_scaling_stat_distribution';

  @override
  Future<int> copyScalingStatDistribution(int key) async {
    final source = await getScalingStatDistribution(key);
    if (source == null) {
      throw RecordNotFoundException('record not found');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeScalingStatDistribution(copied);
    return copied.id;
  }

  @override
  Future<ScalingStatDistributionEntity> createScalingStatDistribution() async {
    return ScalingStatDistributionEntity(id: await _getNextId());
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 32767) {
      throw IdExhaustedException(
        'ScalingStatDistribution ID exceeds the range referenceable by item templates',
      );
    }
    return id;
  }
}
