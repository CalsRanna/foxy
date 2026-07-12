import 'package:flutter/material.dart';
import 'package:foxy/page/player_create_info/player_create_info_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PlayerCreateInfoView extends StatefulWidget {
  final int? race;
  final int? playerClass;
  const PlayerCreateInfoView({super.key, this.race, this.playerClass});

  @override
  State<PlayerCreateInfoView> createState() => _PlayerCreateInfoViewState();
}

class _PlayerCreateInfoViewState extends State<PlayerCreateInfoView> {
  final viewModel = GetIt.instance.get<PlayerCreateInfoDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(race: widget.race, playerClass: widget.playerClass);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      // 复合主键 (race, class)：新建可改，编辑只读
      final pkReadOnly = !viewModel.isNew.value;
      return _buildBody(context, pkReadOnly: pkReadOnly);
    });
  }

  Widget _buildBody(BuildContext context, {required bool pkReadOnly}) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FoxyFormSection(
            title: '基本信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: '种族',
                      child: FoxyNumberInput<int>(
                        placeholder: 'race',
                        fieldController: viewModel.raceController,
                        readOnly: pkReadOnly,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '职业',
                      child: FoxyNumberInput<int>(
                        placeholder: 'class',
                        fieldController: viewModel.playerClassController,
                        readOnly: pkReadOnly,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '地图',
                      child: FoxyNumberInput<int>(
                        placeholder: 'map',
                        fieldController: viewModel.mapController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '区域',
                      child: FoxyNumberInput<int>(
                        placeholder: 'zone',
                        fieldController: viewModel.zoneController,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FoxyFormItem(
                      label: 'X坐标',
                      child: FoxyNumberInput<double>(
                        placeholder: 'position_x',
                        fieldController: viewModel.positionXController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: 'Y坐标',
                      child: FoxyNumberInput<double>(
                        placeholder: 'position_y',
                        fieldController: viewModel.positionYController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: 'Z坐标',
                      child: FoxyNumberInput<double>(
                        placeholder: 'position_z',
                        fieldController: viewModel.positionZController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '朝向',
                      child: FoxyNumberInput<double>(
                        placeholder: 'orientation',
                        fieldController: viewModel.orientationController,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              SizedBox(width: 8),
              ShadButton.ghost(
                onPressed: () => viewModel.pop(),
                child: Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
