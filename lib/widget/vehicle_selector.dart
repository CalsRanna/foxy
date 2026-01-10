import 'package:flutter/material.dart';
import 'package:foxy/model/vehicle.dart';
import 'package:foxy/repository/vehicle_repository.dart';
import 'package:foxy/widget/entity_selector.dart';

/// 载具选择器
class VehicleSelector extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;

  const VehicleSelector({
    super.key,
    required this.controller,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return EntitySelector<Vehicle>(
      controller: controller,
      placeholder: placeholder,
      title: '选择载具',
      searchFields: [
        SelectorSearchField(
          name: 'id',
          label: '编号',
          placeholder: '载具ID',
        ),
      ],
      columns: [
        SelectorColumn(name: 'id', label: '编号', width: 100),
        SelectorColumn(name: 'flags', label: '标识', width: 100),
        SelectorColumn(name: 'turnSpeed', label: '转向速度'),
      ],
      onSearch: _onSearch,
      getId: (item) => item.id,
      getCellValue: _getCellValue,
    );
  }

  Future<SelectorSearchResult<Vehicle>> _onSearch(
    Map<String, String> params,
    int page,
  ) async {
    final repository = VehicleRepository();
    final id = params['id'];
    final items = await repository.search(id: id, page: page);
    final total = await repository.count(id: id);
    return SelectorSearchResult(items: items, total: total);
  }

  String _getCellValue(Vehicle item, String columnName) {
    return switch (columnName) {
      'id' => item.id.toString(),
      'flags' => item.flags.toString(),
      'turnSpeed' => item.turnSpeed.toString(),
      _ => '',
    };
  }
}
