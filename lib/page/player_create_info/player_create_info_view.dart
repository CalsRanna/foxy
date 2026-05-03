import 'package:flutter/material.dart';
import 'package:foxy/page/player_create_info/player_create_info_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
    final isNew = widget.race == null || widget.playerClass == null;

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          ShadCard(padding: EdgeInsets.all(16), child: Column(spacing: 8, children: [
            Row(spacing: 8, children: [
              Expanded(child: FormItem(label: '种族', placeholder: 'race', child: FoxyNumberInput<int>(value: viewModel.race.value, onChanged: (v) => viewModel.race.value = v))),
              Expanded(child: FormItem(label: '职业', placeholder: 'class', child: FoxyNumberInput<int>(value: viewModel.playerClass.value, onChanged: (v) => viewModel.playerClass.value = v))),
              Expanded(child: FormItem(label: '地图', placeholder: 'map', child: FoxyNumberInput<int>(value: viewModel.map.value, onChanged: (v) => viewModel.map.value = v))),
              Expanded(child: FormItem(label: '区域', placeholder: 'zone', child: FoxyNumberInput<int>(value: viewModel.zone.value, onChanged: (v) => viewModel.zone.value = v))),
            ]),
            Row(spacing: 8, children: [
              Expanded(child: FormItem(label: 'X坐标', placeholder: 'position_x', child: FoxyNumberInput<double>(value: viewModel.positionX.value, onChanged: (v) => viewModel.positionX.value = v))),
              Expanded(child: FormItem(label: 'Y坐标', placeholder: 'position_y', child: FoxyNumberInput<double>(value: viewModel.positionY.value, onChanged: (v) => viewModel.positionY.value = v))),
              Expanded(child: FormItem(label: 'Z坐标', placeholder: 'position_z', child: FoxyNumberInput<double>(value: viewModel.positionZ.value, onChanged: (v) => viewModel.positionZ.value = v))),
              Expanded(child: FormItem(label: '朝向', placeholder: 'orientation', child: FoxyNumberInput<double>(value: viewModel.orientation.value, onChanged: (v) => viewModel.orientation.value = v))),
            ]),
          ])),
          Row(
            children: [
              ShadButton(
                onPressed: () => isNew ? viewModel.save(context) : viewModel.update(context),
                child: Text('保存'),
              ),
              SizedBox(width: 8),
              ShadButton.ghost(onPressed: () => viewModel.pop(), child: Text('取消')),
            ],
          ),
        ],
      ),
    );
  }
}
