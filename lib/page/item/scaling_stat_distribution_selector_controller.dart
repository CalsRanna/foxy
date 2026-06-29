import 'package:foxy/controller/selector_controller.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:get_it/get_it.dart';

class ScalingStatDistributionSelectorController extends SelectorController<BriefItemEnchantmentTemplateEntity> {
  final _repository = GetIt.instance.get<ScalingStatDistributionRepository>();

  String idFilter = '';

  @override
  String get errorLabel => '搜索缩放分布失败';

  @override
  Future<void> performSearch() async {
    final id = idFilter.isEmpty ? null : idFilter;
    final result = await _repository.getScalingStatDistributions(id: id, page: page);
    final count = await _repository.countScalingStatDistributions(id: id);
    items = result;
    total = count;
  }

  @override
  void clearFilters() {
    idFilter = '';
  }
}
