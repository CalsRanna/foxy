import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/smart_script/smart_script_view.dart';

@RoutePage()
class SmartScriptDetailPage extends StatefulWidget {
  final int? entryOrGuid;
  final int? sourceType;
  final int? id;
  final int? link;

  const SmartScriptDetailPage({
    super.key,
    this.entryOrGuid,
    this.sourceType,
    this.id,
    this.link,
  });

  @override
  State<SmartScriptDetailPage> createState() => _SmartScriptDetailPageState();
}

class _SmartScriptDetailPageState extends State<SmartScriptDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildHeader(),
        SmartScriptView(
          entryOrGuid: widget.entryOrGuid,
          sourceType: widget.sourceType,
          id: widget.id,
          link: widget.link,
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final isNew = widget.entryOrGuid == null;
    final label = isNew
        ? '新建脚本'
        : '脚本 ${widget.entryOrGuid}/${widget.sourceType}/${widget.id}/${widget.link}';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(label, style: textStyle);
    return Padding(padding: EdgeInsets.only(bottom: 12), child: text);
  }
}
