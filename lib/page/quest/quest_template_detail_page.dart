import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/quest_template_key.dart';
import 'package:foxy/page/quest/creature_quest_ender_view.dart';
import 'package:foxy/page/quest/creature_quest_starter_view.dart';
import 'package:foxy/page/quest/game_object_quest_ender_view.dart';
import 'package:foxy/page/quest/game_object_quest_starter_view.dart';
import 'package:foxy/page/quest/quest_offer_reward_view.dart';
import 'package:foxy/page/quest/quest_request_items_view.dart';
import 'package:foxy/page/quest/quest_template_addon_view.dart';
import 'package:foxy/page/quest/quest_template_detail_view_model.dart';
import 'package:foxy/page/quest/quest_template_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class QuestTemplateDetailPage extends StatefulWidget {
  final QuestTemplateKey? questTemplateKey;

  const QuestTemplateDetailPage({super.key, this.questTemplateKey});

  @override
  State<QuestTemplateDetailPage> createState() =>
      _QuestTemplateDetailPageState();
}

class _QuestTemplateDetailPageState extends State<QuestTemplateDetailPage> {
  final viewModel = GetIt.instance.get<QuestTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.questTemplateKey);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final key = viewModel.persistedKey.value;
      final template = viewModel.template.value;
      final questId = key?.id ?? 0;
      final name = key == null
          ? '新建任务'
          : template.logTitle.isNotEmpty
          ? template.logTitle
          : '任务 #${key.id}';
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          FoxyTab(
            tabs: const [
              Text('任务模板'),
              Text('模板补充'),
              Text('提交物品'),
              Text('发放奖励'),
              Text('开始生物'),
              Text('结束生物'),
              Text('开始物体'),
              Text('结束物体'),
            ],
            contents: [
              QuestTemplateView(viewModel: viewModel),
              QuestTemplateAddonView(
                key: ValueKey('addon-$questId'),
                questId: questId,
              ),
              QuestRequestItemsView(
                key: ValueKey('request-$questId'),
                questId: questId,
              ),
              QuestOfferRewardView(
                key: ValueKey('reward-$questId'),
                questId: questId,
              ),
              CreatureQueststarterView(
                key: ValueKey('creature-start-$questId'),
                questId: questId,
              ),
              CreatureQuestEnderView(
                key: ValueKey('creature-end-$questId'),
                questId: questId,
              ),
              GameObjectQuestStarterView(
                key: ValueKey('gameobject-start-$questId'),
                questId: questId,
              ),
              GameObjectQuestEnderView(
                key: ValueKey('gameobject-end-$questId'),
                questId: questId,
              ),
            ],
            disabledIndexes: key == null
                ? const {1, 2, 3, 4, 5, 6, 7}
                : const {},
          ),
        ],
      );
    });
  }
}
