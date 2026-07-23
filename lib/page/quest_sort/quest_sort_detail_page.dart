import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/page/quest_sort/quest_sort_detail_view_model.dart';
import 'package:foxy/page/quest_sort/quest_sort_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class QuestSortDetailPage extends StatefulWidget {
  final int? questSortKey;

  const QuestSortDetailPage({super.key, this.questSortKey});

  @override
  State<QuestSortDetailPage> createState() => _QuestSortDetailPageState();
}

class _QuestSortDetailPageState extends State<QuestSortDetailPage> {
  final viewModel = GetIt.instance.get<QuestSortDetailViewModel>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.questSortKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：$error');
    }
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
      final entity = viewModel.entity.value;
      final name = key == null
          ? '新建任务排序'
          : entity?.sortNameLangZhCN.isNotEmpty == true
          ? entity?.sortNameLangZhCN ?? ''
          : '任务排序 #$key';
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
            tabs: const [Text('任务排序')],
            contents: [QuestSortView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
