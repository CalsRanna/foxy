import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/constant/player_create_info_constants.dart';
import 'package:foxy/page/player_create_info/player_create_info_detail_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class PlayerCreateInfoView extends StatelessWidget {
  final PlayerCreateInfoDetailViewModel viewModel;

  const PlayerCreateInfoView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
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
                      child: FoxyIntShadSelect(
                        controller: viewModel.raceController,
                        options: kPlayerRaceOptions,
                        placeholder: const Text('race'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '职业',
                      child: FoxyIntShadSelect(
                        controller: viewModel.playerClassController,
                        options: kPlayerClassOptions,
                        placeholder: const Text('class'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '地图',
                      child: FoxyEntityPicker(
                        placeholder: 'map',
                        controller: viewModel.mapController,
                        delegate: FoxyEntityPickerDelegates.playerCreateMap,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '区域',
                      child: FoxyEntityPicker(
                        placeholder: 'zone',
                        controller: viewModel.zoneController,
                        delegate: FoxyEntityPickerDelegates.areaTable,
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
                        controller: viewModel.positionXController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: 'Y坐标',
                      child: FoxyNumberInput<double>(
                        placeholder: 'position_y',
                        controller: viewModel.positionYController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: 'Z坐标',
                      child: FoxyNumberInput<double>(
                        placeholder: 'position_z',
                        controller: viewModel.positionZController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FoxyFormItem(
                      label: '朝向',
                      child: FoxyNumberInput<double>(
                        placeholder: 'orientation',
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
              Watch(
                (_) => ShadButton(
                  enabled: !viewModel.submitting.value,
                  onPressed: () => _persist(context),
                  child: Text('保存'),
                ),
              ),
              SizedBox(width: 8),
              ShadButton.ghost(onPressed: _goBack, child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _persist(BuildContext context) async {
    try {
      await viewModel.persist();
      if (!context.mounted) return;
      GetIt.instance.get<RouterFacade>().updateCurrentLabel(
        '出生信息 ${viewModel.persistedKey.value}',
      );
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }
}
