import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_detail_view_model.dart';
import 'package:foxy/page/spell/spell_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class SpellDetailPage extends StatefulWidget {
  final int? id;

  const SpellDetailPage({super.key, this.id});

  @override
  State<SpellDetailPage> createState() => _SpellDetailPageState();
}

class _SpellDetailPageState extends State<SpellDetailPage> {
  final viewModel = GetIt.instance.get<SpellDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Text('基本信息'),
      Text('奖励系数'),
      Text('自定义属性'),
      Text('区域技能'),
      Text('技能组'),
      Text('链接技能'),
      Text('技能排行'),
      Text('技能掉落'),
    ];

    var tabContents = [
      SpellView(id: widget.id),
      _placeholderTab('奖励系数功能开发中...'),
      _placeholderTab('自定义属性功能开发中...'),
      _placeholderTab('区域技能功能开发中...'),
      _placeholderTab('技能组功能开发中...'),
      _placeholderTab('链接技能功能开发中...'),
      _placeholderTab('技能排行功能开发中...'),
      _placeholderTab('技能掉落功能开发中...'),
    ];

    var tabBar = FoxyTab(tabs: tabs, contents: tabContents);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var label = widget.id != null ? '法术 ${widget.id}' : '新建法术';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(label, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }

  Widget _placeholderTab(String message) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Center(child: Text(message)),
    );
  }
}
