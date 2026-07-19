import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/quest_info_key.dart';
import 'package:foxy/page/quest_info/quest_info_detail_view_model.dart';
import 'package:foxy/page/quest_info/quest_info_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class QuestInfoDetailPage extends StatefulWidget {
  final QuestInfoKey? questInfoKey;

  const QuestInfoDetailPage({super.key, this.questInfoKey});

  @override
  State<QuestInfoDetailPage> createState() => _QuestInfoDetailPageState();
}

class _QuestInfoDetailPageState extends State<QuestInfoDetailPage> {
  final viewModel = GetIt.instance.get<QuestInfoDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.questInfoKey);
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
      final entity = viewModel.info.value;
      final name = key == null
          ? '新建任务信息'
          : entity.infoNameLangZhCN.isNotEmpty
          ? entity.infoNameLangZhCN
          : '任务信息 #${key.id}';
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
            tabs: const [Text('任务信息')],
            contents: [QuestInfoView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
