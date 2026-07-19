import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/smart_script_key.dart';
import 'package:foxy/page/smart_script/smart_script_detail_view_model.dart';
import 'package:foxy/page/smart_script/smart_script_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class SmartScriptDetailPage extends StatefulWidget {
  final SmartScriptKey? scriptKey;

  const SmartScriptDetailPage({super.key, this.scriptKey});

  @override
  State<SmartScriptDetailPage> createState() => _SmartScriptDetailPageState();
}

class _SmartScriptDetailPageState extends State<SmartScriptDetailPage> {
  final viewModel = GetIt.instance.get<SmartScriptDetailViewModel>();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.scriptKey);
  }

  @override
  Widget build(BuildContext context) {
    var tabs = [const Text('脚本详情')];
    var tabContents = [SmartScriptView(viewModel: viewModel)];
    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    return Watch((_) {
      final key = viewModel.persistedKey.value;
      final label = key == null
          ? '新建脚本'
          : '脚本 ${key.entryOrGuid}/${key.sourceType}/${key.id}/${key.link}';
      var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
      var text = Text(label, style: textStyle);
      return Padding(padding: EdgeInsets.only(bottom: 12), child: text);
    });
  }
}
