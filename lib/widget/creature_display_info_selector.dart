import 'package:flutter/material.dart';
import 'package:foxy/model/creature_display_info.dart';
import 'package:foxy/repository/creature_display_info_repository.dart';
import 'package:foxy/widget/entity_selector.dart';

/// 生物模型选择器
class CreatureDisplayInfoSelector extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;

  const CreatureDisplayInfoSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return EntitySelector<CreatureDisplayInfo>(
      controller: controller,
      placeholder: placeholder,
      title: '选择模型',
      searchFields: [
        SelectorSearchField(
          name: 'id',
          label: '编号',
          placeholder: '模型ID',
        ),
      ],
      columns: [
        SelectorColumn(name: 'id', label: '编号', width: 100),
        SelectorColumn(name: 'modelId', label: '模型', width: 100),
        SelectorColumn(name: 'scale', label: '缩放'),
      ],
      onSearch: _onSearch,
      getId: (item) => item.id,
      getCellValue: _getCellValue,
    );
  }

  Future<SelectorSearchResult<CreatureDisplayInfo>> _onSearch(
    Map<String, String> params,
    int page,
  ) async {
    final repository = CreatureDisplayInfoRepository();
    final id = params['id'];
    final items = await repository.search(id: id, page: page);
    final total = await repository.count(id: id);
    return SelectorSearchResult(items: items, total: total);
  }

  String _getCellValue(CreatureDisplayInfo item, String columnName) {
    return switch (columnName) {
      'id' => item.id.toString(),
      'modelId' => item.modelId.toString(),
      'scale' => item.creatureModelScale.toString(),
      _ => '',
    };
  }
}
