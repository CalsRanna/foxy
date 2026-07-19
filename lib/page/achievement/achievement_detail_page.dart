import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/achievement/achievement_detail_view_model.dart';
import 'package:foxy/page/achievement/achievement_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class AchievementDetailPage extends StatefulWidget {
  final int? achievementKey;

  const AchievementDetailPage({super.key, this.achievementKey});

  @override
  State<AchievementDetailPage> createState() => _AchievementDetailPageState();
}

class _AchievementDetailPageState extends State<AchievementDetailPage> {
  final viewModel = GetIt.instance.get<AchievementDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.achievementKey);
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
      final entity = viewModel.achievement.value;
      final name = key == null
          ? '新建成就'
          : entity.titleLangZhCN.isNotEmpty
          ? entity.titleLangZhCN
          : '成就 #$key';
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
            tabs: const [Text('成就')],
            contents: [AchievementView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
