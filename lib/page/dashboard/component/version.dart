import 'package:flutter/material.dart';
import 'package:foxy/widget/card.dart';

class Version extends StatelessWidget {
  const Version({super.key});

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
    const padding = Padding(padding: EdgeInsets.all(16.0), child: column);
    return const FoxyCard(title: Text('版本信息'), child: padding);
  }
}
