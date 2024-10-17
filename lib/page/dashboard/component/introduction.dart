import 'package:flutter/material.dart';
import 'package:foxy/widget/card.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    const text = Text(
      'Foxy已经很长时间没有更新了，已经适配不上新版本的模拟器了。\n\n'
      '最近有一点空闲时间，于是使用Flutter重构了一版。\n\n'
      '之所以使用Flutter而不是Vue3进行重构，有两方面原因。一是我的技术栈已经全面迁移至Flutter，我'
      '可以使用更少的代码实现更多的功能；二是因为Vue3+Electron这套技术栈，在我个人看来有点臃肿，而'
      '且执行效率不够高。\n\n'
      '希望新的Foxy能继续实现我最初的愿景，做最好的魔兽世界编辑器！',
    );
    final padding = Padding(padding: EdgeInsets.all(16), child: text);
    return FoxyCard(title: Text('介绍'), child: padding);
  }
}
