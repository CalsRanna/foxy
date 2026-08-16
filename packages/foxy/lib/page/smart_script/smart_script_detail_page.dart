import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/smart_script/smart_script_view.dart';
import 'package:foxy/view_model/smart_script_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';

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
  Widget build(BuildContext context) {
    var tabs = [const Text('脚本详情')];
    var tabContents = [SmartScriptView(viewModel: viewModel)];
    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FoxyHeader('脚本详情'),
    );
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.scriptKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }
}
