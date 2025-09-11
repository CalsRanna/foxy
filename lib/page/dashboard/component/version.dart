import 'package:flutter/material.dart';
import 'package:foxy/widget/card.dart';

class Version extends StatelessWidget {
  final String coreVersion;
  final String revision;
  final String databaseVersion;
  final String softwareVersion;

  const Version({
    super.key,
    required this.coreVersion,
    required this.revision,
    required this.databaseVersion,
    required this.softwareVersion,
  });

  @override
  Widget build(BuildContext context) {
    final children = [
      Text('核心版本：$coreVersion'),
      Text('核心修订版本：$revision'),
      Text('数据库版本：$databaseVersion'),
      Text('软件版本：$softwareVersion'),
    ];
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    final padding = Padding(padding: EdgeInsets.all(16.0), child: column);
    return FoxyCard(title: Text('版本信息'), child: padding);
  }
}
