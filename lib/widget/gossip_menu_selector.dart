import 'package:flutter/material.dart';
import 'package:foxy/model/gossip_menu.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/widget/entity_selector.dart';

/// 对话菜单选择器
class GossipMenuSelector extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;

  const GossipMenuSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return EntitySelector<GossipMenu>(
      controller: controller,
      placeholder: placeholder,
      title: '选择对话菜单',
      searchFields: [
        SelectorSearchField(
          name: 'menuId',
          label: '菜单ID',
          placeholder: 'MenuID',
        ),
      ],
      columns: [
        SelectorColumn(name: 'menuId', label: '菜单ID', width: 120),
        SelectorColumn(name: 'textId', label: '文本ID'),
      ],
      onSearch: _onSearch,
      getId: (item) => item.menuId,
      getCellValue: _getCellValue,
    );
  }

  Future<SelectorSearchResult<GossipMenu>> _onSearch(
    Map<String, String> params,
    int page,
  ) async {
    final repository = GossipMenuRepository();
    final menuId = params['menuId'];
    final items = await repository.search(menuId: menuId, page: page);
    final total = await repository.count(menuId: menuId);
    return SelectorSearchResult(items: items, total: total);
  }

  String _getCellValue(GossipMenu item, String columnName) {
    return switch (columnName) {
      'menuId' => item.menuId.toString(),
      'textId' => item.textId.toString(),
      _ => '',
    };
  }
}
