import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final int activityLogCount;
  final int featureCount;
  const Welcome({
    super.key,
    required this.activityLogCount,
    required this.featureCount,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = ClipOval(
      child: Image.asset(
        'asset/image/icon.png',
        fit: BoxFit.cover,
        height: 80,
        width: 80,
      ),
    );
    const supportChildren = [
      Text('欢迎使用Foxy！', style: TextStyle(fontSize: 20)),
      Text('支持 Azeroth | 3.3.5 12340 | Mysql 8.x'),
    ];
    const support = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: supportChildren,
    );
    var module = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [Text('模块数'), Text('$featureCount')],
    );
    var count = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [Text('使用次数'), Text('$activityLogCount')],
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
