import 'package:flutter/material.dart';
import 'package:foxy/model/loot_template.dart';
import 'package:foxy/repository/loot_template_repository.dart';
import 'package:foxy/widget/entity_selector.dart';

/// 掉落模板选择器
class LootTemplateSelector extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;
  final LootTableType tableType;
  final String title;

  const LootTemplateSelector({
    super.key,
    required this.controller,
    this.placeholder,
    required this.tableType,
    required this.title,
  });

  /// 击杀掉落选择器
  factory LootTemplateSelector.creature({
    Key? key,
    required TextEditingController controller,
    String? placeholder,
  }) {
    return LootTemplateSelector(
      key: key,
      controller: controller,
      placeholder: placeholder,
      tableType: LootTableType.creature,
      title: '选择击杀掉落',
    );
  }

  /// 偷窃掉落选择器
  factory LootTemplateSelector.pickpocket({
    Key? key,
    required TextEditingController controller,
    String? placeholder,
  }) {
    return LootTemplateSelector(
      key: key,
      controller: controller,
      placeholder: placeholder,
      tableType: LootTableType.pickpocket,
      title: '选择偷窃掉落',
    );
  }

  /// 剥皮掉落选择器
  factory LootTemplateSelector.skinning({
    Key? key,
    required TextEditingController controller,
    String? placeholder,
  }) {
    return LootTemplateSelector(
      key: key,
      controller: controller,
      placeholder: placeholder,
      tableType: LootTableType.skinning,
      title: '选择剥皮掉落',
    );
  }

  @override
  Widget build(BuildContext context) {
    return EntitySelector<LootTemplate>(
      controller: controller,
      placeholder: placeholder,
      title: title,
      searchFields: [
        SelectorSearchField(
          name: 'entry',
          label: '编号',
          placeholder: 'Entry',
        ),
      ],
      columns: [
        SelectorColumn(name: 'entry', label: '掉落编号'),
      ],
      onSearch: _onSearch,
      getId: (item) => item.entry,
      getCellValue: _getCellValue,
    );
  }

  Future<SelectorSearchResult<LootTemplate>> _onSearch(
    Map<String, String> params,
    int page,
  ) async {
    final repository = LootTemplateRepository(tableType);
    final entry = params['entry'];
    final items = await repository.searchDistinctEntries(entry: entry, page: page);
    final total = await repository.count(entry: entry);
    return SelectorSearchResult(items: items, total: total);
  }

  String _getCellValue(LootTemplate item, String columnName) {
    return switch (columnName) {
      'entry' => item.entry.toString(),
      _ => '',
    };
  }
}
