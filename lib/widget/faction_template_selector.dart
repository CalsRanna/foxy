import 'package:flutter/material.dart';
import 'package:foxy/model/faction_template.dart';
import 'package:foxy/repository/faction_template_repository.dart';
import 'package:foxy/widget/entity_selector.dart';

/// 阵营选择器
class FactionTemplateSelector extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;

  const FactionTemplateSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return EntitySelector<FactionTemplate>(
      controller: controller,
      placeholder: placeholder,
      title: '选择阵营',
      searchFields: [
        SelectorSearchField(
          name: 'id',
          label: '编号',
          placeholder: '阵营ID',
        ),
      ],
      columns: [
        SelectorColumn(name: 'id', label: '编号', width: 100),
        SelectorColumn(name: 'faction', label: '阵营', width: 100),
        SelectorColumn(name: 'flags', label: '标识'),
      ],
      onSearch: _onSearch,
      getId: (item) => item.id,
      getCellValue: _getCellValue,
    );
  }

  Future<SelectorSearchResult<FactionTemplate>> _onSearch(
    Map<String, String> params,
    int page,
  ) async {
    final repository = FactionTemplateRepository();
    final id = params['id'];
    final items = await repository.search(id: id, page: page);
    final total = await repository.count(id: id);
    return SelectorSearchResult(items: items, total: total);
  }

  String _getCellValue(FactionTemplate item, String columnName) {
    return switch (columnName) {
      'id' => item.id.toString(),
      'faction' => item.faction.toString(),
      'flags' => item.flags.toString(),
      _ => '',
    };
  }
}
