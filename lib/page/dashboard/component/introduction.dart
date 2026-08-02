import 'package:flutter/material.dart';
import 'package:foxy/widget/foxy_card.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    const text = Text(
      'Foxy 是一款基于 Flutter 开发的 AzerothCore 数据库可视化管理工具，'
      '覆盖生物、物品、任务、法术、游戏对象、对话、内建脚本等 130+ 张核心表。\n\n'
      '从列表检索、详情编辑到关联子表维护，Foxy 为内容制作提供更简单的方式，'
      '让仿官方服务器内容的制作高效而直观。\n\n'
      '希望新的Foxy能继续实现最初的愿景——做最好的魔兽世界编辑器。',
    );
    final padding = Padding(padding: EdgeInsets.all(16), child: text);
    return FoxyCard(title: Text('介绍'), child: padding);
  }
}
