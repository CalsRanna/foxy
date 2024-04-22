import 'package:flutter/material.dart';
import 'package:foxy/page/dashboard/component/frequent_module.dart';
import 'package:foxy/widget/card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final outline = colorScheme.outline.withOpacity(0.85);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('首页', style: TextStyle(color: outline)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('/'),
            ),
            Text('工作台', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '工作台',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              color: Colors.red,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('欢迎使用Foxy！', style: TextStyle(fontSize: 20)),
                Text('支持 Mysql 8.x | Trinity Core | 3.3.5 12340')
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text('模块数'), Text('58')],
            ),
            VerticalDivider(
              thickness: 1,
              width: 1,
            ),
            Column(),
            VerticalDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text('使用次数'), Text('2,223')],
            )
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    FrequentModuleComponent(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: FoxyCard(
                          title: Text('动态'),
                          child: Expanded(
                              child: ListView(
                            children: [
                              ListTile(title: Text('新建生物 XXX')),
                              Divider(),
                              ListTile(title: Text('新建生物 XXX')),
                              Divider(),
                              ListTile(title: Text('新建生物 XXX')),
                              Divider(),
                              ListTile(title: Text('新建生物 XXX')),
                              Divider(),
                              ListTile(title: Text('新建生物 XXX')),
                              Divider(),
                              ListTile(title: Text('新建生物 XXX')),
                              Divider(),
                              ListTile(title: Text('新建生物 XXX')),
                              Divider(),
                              ListTile(title: Text('新建生物 XXX')),
                              Divider(),
                              ListTile(title: Text('新建生物 XXX')),
                            ],
                          ))),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                flex: 1,
                child: Column(children: [
                  _Introduction(),
                  SizedBox(height: 16),
                  _Version()
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _Introduction extends StatelessWidget {
  const _Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return const FoxyCard(
      title: Text('介绍'),
      child: Text(
        'Foxy已经很长时间没有更新了，但是它仍然很好用。\n\n'
        '最近有一点空闲时间，于是使用Flutter重构了一版。\n\n'
        '之所以使用Flutter而不是Vue3进行重构，有两方面原因。一是我的技术栈已经全面迁移至Flutter，我'
        '可以使用更精炼的代码实现更多的功能；二是因为Vue3+Electron这套技术栈，在我个人看来有点臃肿，而'
        '且执行效率不够高。\n\n'
        '希望新的Foxy能继续实现我最初的愿景，做最好的魔兽世界编辑器！',
      ),
    );
  }
}

class _Version extends StatelessWidget {
  const _Version({super.key});

  @override
  Widget build(BuildContext context) {
    return const FoxyCard(
      title: Text('版本信息'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '核心版本：TrinityCore rev. 12bb3efea6af 2024-04-15 21:12:55 +0200 (3.3.5 branch) (Win64, RelWithDebInfo, Static)'),
          Text('核心修订版本：12bb3efea6af'),
          Text('数据库版本：TDB 335.24041'),
          Text('软件版本：0.3.1'),
        ],
      ),
    );
  }
}
