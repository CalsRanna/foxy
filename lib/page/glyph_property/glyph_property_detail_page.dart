import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/glyph_property/glyph_property_detail_view_model.dart';
import 'package:foxy/page/glyph_property/glyph_property_view.dart';
import 'package:foxy/widget/tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';

@RoutePage()
class GlyphPropertyDetailPage extends StatefulWidget {
  final int? id;
  const GlyphPropertyDetailPage({super.key, this.id});

  @override
  State<GlyphPropertyDetailPage> createState() =>
      _GlyphPropertyDetailPageState();
}

class _GlyphPropertyDetailPageState extends State<GlyphPropertyDetailPage> {
  final viewModel = GetIt.instance.get<GlyphPropertyDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(id: widget.id);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tabs = [Text('属性信息')];
    var tabContents = [GlyphPropertyView(entry: widget.id)];
    var tabBar = Watch((_) {
      return FoxyTab(tabs: tabs, contents: tabContents);
    });
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_buildHeader(), tabBar],
    );
  }

  Widget _buildHeader() {
    var name = widget.id == null ? '新建雕文属性' : '雕文属性';
    var textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    var text = Text(name, style: textStyle);
    var edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: text);
  }
}
