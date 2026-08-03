import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/achievement/achievement_view.dart';
import 'package:foxy/view_model/achievement_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
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
  Widget build(BuildContext context) {
    // Watch 拆分为标题区与页签区:编辑保存只更新标题,不重建表单。
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Watch((_) {
          final key = viewModel.persistedKey.value;
          final entity = viewModel.entity.value;
          final name = key == null
              ? '新建成就'
              : entity?.titleLangZhCN.isNotEmpty == true
              ? entity?.titleLangZhCN ?? ''
              : '成就 #$key';
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          );
        }),
        Watch((_) {
          final key = viewModel.persistedKey.value;
          return FoxyTab(
            tabs: const [Text('成就')],
            contents: [
              AchievementView(
                key: ValueKey('main-$key'),
                viewModel: viewModel,
              ),
            ],
          );
        }),
      ],
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.achievementKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${foxyErrorMessage(error)}');
    }
  }
}
