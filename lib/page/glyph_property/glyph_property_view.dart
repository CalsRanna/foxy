import 'package:flutter/material.dart';
import 'package:foxy/constant/glyph_property_constants.dart';
import 'package:foxy/page/glyph_property/glyph_property_detail_view_model.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
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
    final idInput = FoxyFormItem(
      label: '编号',
      child: FoxyNumberInput<int>(
        placeholder: 'ID',
        controller: viewModel.idController,
        readOnly: true,
      ),
    );

    /// Property
    final spellIdInput = FoxyFormItem(
      label: '法术',
      child: FoxyEntityPicker(
        placeholder: 'SpellID',
        controller: viewModel.spellIdController,
        delegate: FoxyEntityPickerDelegates.spell,
      ),
    );
    final glyphSlotFlagsInput = FoxyFormItem(
      label: '雕文类型',
      child: FoxyIntShadSelect(
        controller: viewModel.glyphSlotFlagsController,
        options: kGlyphPropertySlotTypeOptions,
        placeholder: const Text('GlyphSlotFlags'),
      ),
    );
    final spellIconIdInput = FoxyFormItem(
      label: '法术图标',
      child: FoxyEntityPicker(
        placeholder: 'SpellIconID',
        controller: viewModel.spellIconIdController,
        delegate: FoxyEntityPickerDelegates.spellIcon,
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
          FoxyFormSection(title: '属性信息', children: propertyRows),
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
