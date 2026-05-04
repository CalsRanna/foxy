import 'package:signals/signals.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class ScalingStatDistributionSelectorViewModel {
  final _repository = ScalingStatDistributionRepository();

  final idFilter = signal('');
  final items = signal<List<BriefItemEnchantmentTemplateEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final id = idFilter.value.isEmpty ? null : idFilter.value;
      final items = await _repository.getScalingStatDistributions(
        id: id,
        page: page.value,
      );
      final total = await _repository.countScalingStatDistributions(id: id);
      this.items.value = items;
      this.total.value = total;
    } catch (e) {
      LoggerUtil.instance.e('搜索缩放分布失败: $e');
      DialogUtil.instance.error('搜索缩放分布失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    idFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
