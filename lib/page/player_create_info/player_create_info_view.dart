import 'package:flutter/material.dart';
import 'package:foxy/page/player_create_info/player_create_info_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
              Expanded(child: FormItem(controller: viewModel.raceController, label: '种族', placeholder: 'race')),
              Expanded(child: FormItem(controller: viewModel.classController, label: '职业', placeholder: 'class')),
              Expanded(child: FormItem(controller: viewModel.mapController, label: '地图', placeholder: 'map')),
              Expanded(child: FormItem(controller: viewModel.zoneController, label: '区域', placeholder: 'zone')),
            ]),
            Row(spacing: 8, children: [
              Expanded(child: FormItem(controller: viewModel.positionXController, label: 'X坐标', placeholder: 'position_x')),
              Expanded(child: FormItem(controller: viewModel.positionYController, label: 'Y坐标', placeholder: 'position_y')),
              Expanded(child: FormItem(controller: viewModel.positionZController, label: 'Z坐标', placeholder: 'position_z')),
              Expanded(child: FormItem(controller: viewModel.orientationController, label: '朝向', placeholder: 'orientation')),
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
