import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = _Avatar();
    const supportChildren = [
      Text('欢迎使用Foxy！', style: TextStyle(fontSize: 20)),
      Text('支持 Azeroth / Trinity Core | 3.3.5 12340 | Mysql 5.x / 8.x'),
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
      count,
    ];
    return Row(children: children);
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final onPrimary = colorScheme.onPrimary;
    final boxDecoration = BoxDecoration(color: primary, shape: BoxShape.circle);
    final username = 'Foxy';
    var textStyle = TextStyle(
      color: onPrimary,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
    var text = Text(username.toUpperCase(), style: textStyle);
    return Container(
      decoration: boxDecoration,
      width: 80,
      height: 80,
      child: Center(child: text),
    );
  }
}
