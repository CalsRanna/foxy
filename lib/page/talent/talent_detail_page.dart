import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/talent_key.dart';
import 'package:foxy/page/talent/talent_detail_view_model.dart';
import 'package:foxy/page/talent/talent_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class TalentDetailPage extends StatefulWidget {
  final TalentKey? talentKey;

  const TalentDetailPage({super.key, this.talentKey});

  @override
  State<TalentDetailPage> createState() => _TalentDetailPageState();
}

class _TalentDetailPageState extends State<TalentDetailPage> {
  final viewModel = GetIt.instance.get<TalentDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.talentKey);
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
      final name = key == null ? '新建天赋' : '天赋 #${key.id}';
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
            tabs: const [Text('天赋')],
            contents: [TalentView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
