import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/player_create_info/player_create_info_detail_view_model.dart';
import 'package:foxy/page/player_create_info/player_create_info_view.dart';
import 'package:foxy/page/player_create_info/player_create_info_action_view.dart';
import 'package:foxy/page/player_create_info/player_create_info_item_view.dart';
import 'package:foxy/page/player_create_info/player_create_info_spell_custom_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class PlayerCreateInfoDetailPage extends StatefulWidget {
  final int? race;
  final int? playerClass;
  final String? label;

  const PlayerCreateInfoDetailPage({super.key, this.race, this.playerClass, this.label});

  @override
  State<PlayerCreateInfoDetailPage> createState() => _PlayerCreateInfoDetailPageState();
}

class _PlayerCreateInfoDetailPageState extends State<PlayerCreateInfoDetailPage> {
  final viewModel = GetIt.instance.get<PlayerCreateInfoDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    final isNew = widget.race == null;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            isNew ? '新建出生信息' : (widget.label ?? '出生信息'),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        FoxyTab(
          tabs: [Text('出生信息'), Text('动作按钮'), Text('起始物品'), Text('自定义法术')],
          contents: [
            PlayerCreateInfoView(race: widget.race, playerClass: widget.playerClass),
            PlayerCreateInfoActionView(race: widget.race, playerClass: widget.playerClass),
            PlayerCreateInfoItemView(race: widget.race, playerClass: widget.playerClass),
            PlayerCreateInfoSpellCustomView(race: widget.race, playerClass: widget.playerClass),
          ],
        ),
      ],
    );
  }
}
