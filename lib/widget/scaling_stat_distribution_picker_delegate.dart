import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/repository/scaling_stat_distribution_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final scalingStatDistributionPickerDelegate = EntityPickerDelegate<BriefItemEnchantmentTemplateEntity>(
  title: '属性缩放分布',
  errorLabel: '搜索缩放分布失败',
  filters: const [EntityPickerFilter('编号')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (BriefItemEnchantmentTemplateEntity t) => t.entry.toString()),
    EntityPickerColumn(header: '名称', text: (BriefItemEnchantmentTemplateEntity t) => t.name),
  ],
  idOf: (BriefItemEnchantmentTemplateEntity t) => t.entry,
  fetch: (page, v) => GetIt.instance.get<ScalingStatDistributionRepository>().getScalingStatDistributions(
      id: v[0].isEmpty ? null : v[0], page: page),
  count: (v) => GetIt.instance.get<ScalingStatDistributionRepository>()
      .countScalingStatDistributions(id: v[0].isEmpty ? null : v[0]),
);
