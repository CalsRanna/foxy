import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/player_create_info_key.dart';
import 'package:foxy/page/player_create_info/player_create_info_action_view.dart';
import 'package:foxy/page/player_create_info/player_create_info_cast_spell_view.dart';
import 'package:foxy/page/player_create_info/player_create_info_detail_view_model.dart';
import 'package:foxy/page/player_create_info/player_create_info_item_view.dart';
import 'package:foxy/page/player_create_info/player_create_info_skill_view.dart';
import 'package:foxy/page/player_create_info/player_create_info_spell_custom_view.dart';
import 'package:foxy/page/player_create_info/player_create_info_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class PlayerCreateInfoDetailPage extends StatefulWidget {
  final PlayerCreateInfoKey? playerCreateInfoKey;

  const PlayerCreateInfoDetailPage({super.key, this.playerCreateInfoKey});

  @override
  State<PlayerCreateInfoDetailPage> createState() =>
      _PlayerCreateInfoDetailPageState();
}

class _PlayerCreateInfoDetailPageState
    extends State<PlayerCreateInfoDetailPage> {
  final viewModel = GetIt.instance.get<PlayerCreateInfoDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.playerCreateInfoKey);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Watch((_) {
    final key = viewModel.persistedKey.value;
    final label = key == null ? '新建出生信息' : '种族${key.race}-职业${key.class_}';
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        FoxyTab(
          tabs: const [
            Text('出生信息'),
            Text('动作按钮'),
            Text('起始物品'),
            Text('初始技能'),
            Text('自定义法术'),
            Text('登录施法'),
          ],
          contents: [
            PlayerCreateInfoView(viewModel: viewModel),
            PlayerCreateInfoActionView(
              race: key?.race,
              playerClass: key?.class_,
            ),
            PlayerCreateInfoItemView(race: key?.race, playerClass: key?.class_),
            PlayerCreateInfoSkillView(
              race: key?.race,
              playerClass: key?.class_,
            ),
            PlayerCreateInfoSpellCustomView(
              race: key?.race,
              playerClass: key?.class_,
            ),
            PlayerCreateInfoCastSpellView(
              race: key?.race,
              playerClass: key?.class_,
            ),
          ],
          disabledIndexes: key == null ? const {1, 2, 3, 4, 5} : const {},
        ),
      ],
    );
  });
}
