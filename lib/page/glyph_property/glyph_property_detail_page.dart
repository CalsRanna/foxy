import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/glyph_property/glyph_property_detail_view_model.dart';
import 'package:foxy/page/glyph_property/glyph_property_view.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class GlyphPropertyDetailPage extends StatefulWidget {
  final int? glyphPropertyKey;

  const GlyphPropertyDetailPage({super.key, this.glyphPropertyKey});

  @override
  State<GlyphPropertyDetailPage> createState() =>
      _GlyphPropertyDetailPageState();
}

class _GlyphPropertyDetailPageState extends State<GlyphPropertyDetailPage> {
  final viewModel = GetIt.instance.get<GlyphPropertyDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(key: widget.glyphPropertyKey);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final key = viewModel.persistedKey.value;
      final name = key == null ? '新建雕文属性' : '雕文属性 #$key';
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          FoxyTab(
            tabs: const [Text('属性信息')],
            contents: [GlyphPropertyView(viewModel: viewModel)],
          ),
        ],
      );
    });
  }
}
