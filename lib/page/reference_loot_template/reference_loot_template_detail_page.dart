import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/page/reference_loot_template/reference_loot_template_detail_view_model.dart';
import 'package:foxy/page/reference_loot_template/reference_loot_template_view.dart';
import 'package:foxy/entity/reference_loot_template_key.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class ReferenceLootTemplateDetailPage extends StatefulWidget {
  final ReferenceLootTemplateKey? referenceLootTemplateKey;

  const ReferenceLootTemplateDetailPage({
    super.key,
    this.referenceLootTemplateKey,
  });

  @override
  State<ReferenceLootTemplateDetailPage> createState() =>
      _ReferenceLootTemplateDetailPageState();
}

class _ReferenceLootTemplateDetailPageState
    extends State<ReferenceLootTemplateDetailPage> {
  final viewModel = GetIt.instance.get<ReferenceLootTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.referenceLootTemplateKey);
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
      final label = key == null ? '新建关联掉落' : '关联掉落 ${key.entry}-${key.item}';
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
            tabs: const [Text('关联掉落')],
            contents: [ReferenceLootTemplateView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
