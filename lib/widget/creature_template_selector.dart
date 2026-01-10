import 'package:flutter/material.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/model/creature_template_filter_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/widget/entity_selector.dart';

/// 生物模板选择器
class CreatureTemplateSelector extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;

  const CreatureTemplateSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return EntitySelector<BriefCreatureTemplate>(
      controller: controller,
      placeholder: placeholder,
      title: '选择生物模板',
      searchFields: [
        SelectorSearchField(
          name: 'entry',
          label: '编号',
          placeholder: 'entry',
        ),
        SelectorSearchField(
          name: 'name',
          label: '名称',
          placeholder: 'name',
        ),
      ],
      columns: [
        SelectorColumn(name: 'entry', label: '编号', width: 100),
        SelectorColumn(name: 'name', label: '名称'),
        SelectorColumn(name: 'level', label: '等级', width: 100),
      ],
      onSearch: _onSearch,
      getId: (item) => item.entry,
      getCellValue: _getCellValue,
    );
  }

  Future<SelectorSearchResult<BriefCreatureTemplate>> _onSearch(
    Map<String, String> params,
    int page,
  ) async {
    final repository = CreatureTemplateRepository();
    final filter = CreatureTemplateFilterEntity()
      ..entry = params['entry'] ?? ''
      ..name = params['name'] ?? '';
    final items = await repository.getBriefCreatureTemplates(
      page: page,
      filter: filter,
    );
    final total = await repository.count(filter: filter);
    return SelectorSearchResult(items: items, total: total);
  }

  String _getCellValue(BriefCreatureTemplate item, String columnName) {
    return switch (columnName) {
      'entry' => item.entry.toString(),
      'name' => item.displayName,
      'level' => '${item.minLevel}-${item.maxLevel}',
      _ => '',
    };
  }
}
