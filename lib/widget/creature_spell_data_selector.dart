import 'package:flutter/material.dart';
import 'package:foxy/model/creature_spell_data.dart';
import 'package:foxy/repository/creature_spell_data_repository.dart';
import 'package:foxy/widget/entity_selector.dart';

/// 宠物技能选择器
class CreatureSpellDataSelector extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;

  const CreatureSpellDataSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return EntitySelector<CreatureSpellData>(
      controller: controller,
      placeholder: placeholder,
      title: '选择宠物技能',
      searchFields: [
        SelectorSearchField(
          name: 'id',
          label: '编号',
          placeholder: '技能数据ID',
        ),
      ],
      columns: [
        SelectorColumn(name: 'id', label: '编号', width: 80),
        SelectorColumn(name: 'spell1', label: '技能1', width: 80),
        SelectorColumn(name: 'spell2', label: '技能2', width: 80),
        SelectorColumn(name: 'spell3', label: '技能3', width: 80),
        SelectorColumn(name: 'spell4', label: '技能4'),
      ],
      onSearch: _onSearch,
      getId: (item) => item.id,
      getCellValue: _getCellValue,
    );
  }

  Future<SelectorSearchResult<CreatureSpellData>> _onSearch(
    Map<String, String> params,
    int page,
  ) async {
    final repository = CreatureSpellDataRepository();
    final id = params['id'];
    final items = await repository.search(id: id, page: page);
    final total = await repository.count(id: id);
    return SelectorSearchResult(items: items, total: total);
  }

  String _getCellValue(CreatureSpellData item, String columnName) {
    return switch (columnName) {
      'id' => item.id.toString(),
      'spell1' => item.spells1.toString(),
      'spell2' => item.spells2.toString(),
      'spell3' => item.spells3.toString(),
      'spell4' => item.spells4.toString(),
      _ => '',
    };
  }
}
