import 'package:flutter/material.dart';
import 'package:foxy/page/player_create_info/player_create_info_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FormSection(
            title: '基本信息',
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FormItem(
                      label: '种族',
                      placeholder: 'race',
                      child: FoxyNumberInput<int>(
                        controller: viewModel.raceController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FormItem(
                      label: '职业',
                      placeholder: 'class',
                      child: FoxyNumberInput<int>(
                        controller: viewModel.playerClassController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FormItem(
                      label: '地图',
                      placeholder: 'map',
                      child: FoxyNumberInput<int>(
                        controller: viewModel.mapController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FormItem(
                      label: '区域',
                      placeholder: 'zone',
                      child: FoxyNumberInput<int>(
                        controller: viewModel.zoneController,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: FormItem(
                      label: 'X坐标',
                      placeholder: 'position_x',
                      child: FoxyNumberInput<double>(
                        controller: viewModel.positionXController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FormItem(
                      label: 'Y坐标',
                      placeholder: 'position_y',
                      child: FoxyNumberInput<double>(
                        controller: viewModel.positionYController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FormItem(
                      label: 'Z坐标',
                      placeholder: 'position_z',
                      child: FoxyNumberInput<double>(
                        controller: viewModel.positionZController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FormItem(
                      label: '朝向',
                      placeholder: 'orientation',
                      child: FoxyNumberInput<double>(
                        controller: viewModel.orientationController,
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
