import 'package:flutter/material.dart';
import 'package:foxy/constant/item_quality.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/entity/item_template_filter_entity.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final itemTemplatePickerDelegate = EntityPickerDelegate<BriefItemTemplateEntity>(
  title: '物品',
  errorLabel: '搜索失败',
  filters: const [
    EntityPickerFilter('编号'),
    EntityPickerFilter('名称'),
    EntityPickerFilter('描述'),
  ],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (BriefItemTemplateEntity t) => t.entry.toString()),
    EntityPickerColumn(
      header: '名称',
      cell: (BriefItemTemplateEntity t) {
        final color = kItemQualityColors[t.quality] ?? Colors.white;
        return Text(t.displayName, style: TextStyle(color: color), maxLines: 1, overflow: TextOverflow.ellipsis);
      },
    ),
    EntityPickerColumn(header: '物品等级', width: 120, text: (BriefItemTemplateEntity t) => t.itemLevel.toString()),
    EntityPickerColumn(header: '需求等级', width: 120, text: (BriefItemTemplateEntity t) => t.requiredLevel.toString()),
  ],
  idOf: (BriefItemTemplateEntity t) => t.entry,
  fetch: (page, v) => GetIt.instance.get<ItemTemplateRepository>().getBriefItemTemplates(
      filter: ItemTemplateFilterEntity(entry: v[0], name: v[1], description: v[2]), page: page),
  count: (v) => GetIt.instance.get<ItemTemplateRepository>().countItemTemplates(
      filter: ItemTemplateFilterEntity(entry: v[0], name: v[1], description: v[2])),
);
