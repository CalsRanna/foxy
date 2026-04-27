import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/glyph_property/glyph_property_detail_view_model.dart';
import 'package:foxy/page/glyph_property/glyph_property_view.dart';
import 'package:get_it/get_it.dart';

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
    return GlyphPropertyView(entry: widget.id);
  }
}
