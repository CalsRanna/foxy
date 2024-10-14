import 'package:flutter/material.dart';
import 'package:foxy/page/dashboard/component/frequent_module.dart';
import 'package:foxy/page/dashboard/component/trend.dart';
import 'package:foxy/widget/card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const leftChildren = [
      FrequentModuleComponent(),
      SizedBox(height: 16),
      Trend(),
    ];
    const leftColumn = Column(children: leftChildren);
    const rightChildren = [_Introduction(), SizedBox(height: 16), _Version()];
    const rightColumn = Column(children: rightChildren);
    const children = [
      Expanded(flex: 2, child: leftColumn),
      SizedBox(width: 16),
      Expanded(flex: 1, child: rightColumn)
    ];
    const row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    const singleChildScrollView = SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: row,
    );
    const bodyChildren = [
      SizedBox(height: 16),
      _Breadcrumb(),
      SizedBox(height: 16),
      _Header(),
      SizedBox(height: 16),
      _Welcome(),
      SizedBox(height: 16),
      Expanded(child: singleChildScrollView),
    ];
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bodyChildren,
    );
  }
}

class _Breadcrumb extends StatelessWidget {
  const _Breadcrumb();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline.withOpacity(0.85);
    const textStyle = TextStyle(fontWeight: FontWeight.bold);
    const edgeInsets = EdgeInsets.symmetric(horizontal: 8.0);
    final children = [
      Text('首页', style: TextStyle(color: outline)),
      const Padding(padding: edgeInsets, child: Text('/')),
      const Text('工作台', style: textStyle),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: children),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text('工作台', style: textStyle),
    );
  }
}

class _Introduction extends StatelessWidget {
  const _Introduction();

  @override
  Widget build(BuildContext context) {
    const introduction = Text(
      'Foxy已经很长时间没有更新了，但是它仍然很好用。\n\n'
      '最近有一点空闲时间，于是使用Flutter重构了一版。\n\n'
      '之所以使用Flutter而不是Vue3进行重构，有两方面原因。一是我的技术栈已经全面迁移至Flutter，我'
      '可以使用更精炼的代码实现更多的功能；二是因为Vue3+Electron这套技术栈，在我个人看来有点臃肿，而'
      '且执行效率不够高。\n\n'
      '希望新的Foxy能继续实现我最初的愿景，做最好的魔兽世界编辑器！',
    );
    return const FoxyCard(title: Text('介绍'), child: introduction);
  }
}

class _Version extends StatelessWidget {
  const _Version();

  @override
  Widget build(BuildContext context) {
    const children = [
      Text(
          '核心版本：TrinityCore rev. 12bb3efea6af 2024-04-15 21:12:55 +0200 (3.3.5 branch) (Win64, RelWithDebInfo, Static)'),
      Text('核心修订版本：12bb3efea6af'),
      Text('数据库版本：TDB 335.24041'),
      Text('软件版本：0.3.1'),
    ];
    const column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    return const FoxyCard(title: Text('版本信息'), child: column);
  }
}

class _Welcome extends StatelessWidget {
  const _Welcome();

  @override
  Widget build(BuildContext context) {
    const boxDecoration = BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    );
    final avatar = Container(
      decoration: boxDecoration,
      width: 80,
      height: 80,
    );
    const supportChildren = [
      Text('欢迎使用Foxy！', style: TextStyle(fontSize: 20)),
      Text('支持 Mysql 8.x | Trinity Core | 3.3.5 12340')
    ];
    const support = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: supportChildren,
    );
    const module = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [Text('模块数'), Text('58')],
    );
    const count = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [Text('使用次数'), Text('2,223')],
    );
    final children = [
      avatar,
      const SizedBox(width: 16),
      support,
      const Spacer(),
      module,
      const SizedBox(width: 16),
      count
    ];
    const edgeInsets = EdgeInsets.symmetric(horizontal: 16);
    return Padding(padding: edgeInsets, child: Row(children: children));
  }
}
