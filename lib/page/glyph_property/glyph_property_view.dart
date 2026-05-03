import 'package:flutter/material.dart';
import 'package:foxy/page/glyph_property/glyph_property_detail_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class GlyphPropertyView extends StatefulWidget {
  final int? entry;
  const GlyphPropertyView({super.key, this.entry});

  @override
  State<GlyphPropertyView> createState() => _GlyphPropertyViewState();
}

class _GlyphPropertyViewState extends State<GlyphPropertyView> {
  final viewModel = GetIt.instance.get<GlyphPropertyDetailViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(id: widget.entry);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Basic
    final idInput = FormItem(
      label: '编号',
      placeholder: 'ID',
      child: FoxyNumberInput<int>(
        value: viewModel.id.value,
        onChanged: (v) => viewModel.id.value = v,
        readOnly: true,
      ),
    );

    /// Property
    final spellIdInput = FormItem(
      label: '技能编号',
      placeholder: 'SpellID',
      child: FoxyNumberInput<int>(
        value: viewModel.spellId.value,
        onChanged: (v) => viewModel.spellId.value = v,
      ),
    );
    final glyphSlotFlagsInput = FormItem(
      label: '雕文槽标记',
      placeholder: 'GlyphSlotFlags',
      child: FoxyNumberInput<int>(
        value: viewModel.glyphSlotFlags.value,
        onChanged: (v) => viewModel.glyphSlotFlags.value = v,
      ),
    );
    final spellIconIdInput = FormItem(
      label: '技能图标',
      placeholder: 'SpellIconID',
      child: FoxyNumberInput<int>(
        value: viewModel.spellIconId.value,
        onChanged: (v) => viewModel.spellIconId.value = v,
      ),
    );

    /// Card rows
    final propertyRows = [
      Row(
        spacing: 8,
        children: [
          Expanded(child: idInput),
          Expanded(child: spellIdInput),
          Expanded(child: glyphSlotFlagsInput),
          Expanded(child: spellIconIdInput),
        ],
      ),
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          // 属性信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('属性信息'),
          ),
          ShadCard(
            padding: EdgeInsets.all(16),
            child: Column(spacing: 8, children: propertyRows),
          ),
          Row(
            children: [
              ShadButton(
                onPressed: () => viewModel.save(context),
                child: Text('保存'),
              ),
              const SizedBox(width: 8),
              ShadButton.ghost(
                onPressed: () => viewModel.pop(),
                child: Text('取消'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
