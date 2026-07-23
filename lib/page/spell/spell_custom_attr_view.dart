import 'package:flutter/material.dart';
import 'package:foxy/constant/spell_flags.dart';
import 'package:foxy/page/spell/spell_custom_attr_single_editor_view_model.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_flag_picker.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

class SpellCustomAttrView extends StatefulWidget {
  final int spellId;

  const SpellCustomAttrView({super.key, required this.spellId});

  @override
  State<SpellCustomAttrView> createState() => _SpellCustomAttrViewState();
}

class _SpellCustomAttrViewState extends State<SpellCustomAttrView> {
  final viewModel = GetIt.instance.get<SpellCustomAttrSingleEditorViewModel>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant SpellCustomAttrView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spellId != widget.spellId) {
      _initialize();
    }
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(parentKey: widget.spellId);
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  Future<void> _persist() async {
    try {
      await viewModel.persist();
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('自定义属性已保存')));
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(error.toString())));
    }
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      viewModel.entity.value;

      return SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            ShadCard(
              padding: EdgeInsets.all(20),
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: FoxyFormItem(
                          label: '编号',
                          child: FoxyNumberInput<int>(
                            controller: viewModel.spellIdController,
                            placeholder: 'spell_id',
                          ),
                        ),
                      ),
                      Expanded(
                        child: FoxyFormItem(
                          label: '属性',
                          child: FoxyFlagPicker(
                            controller: viewModel.attributesController,
                            flags: kSpellCustomAttributeOptions,
                            title: '自定义属性',
                            placeholder: 'attributes',
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              spacing: 8,
              children: [
                Watch(
                  (_) => ShadButton(
                    enabled: !viewModel.submitting.value,
                    onPressed: () => _persist(),
                    child: Text('保存'),
                  ),
                ),
                ShadButton.ghost(onPressed: () => _goBack(), child: Text('取消')),
              ],
            ),
          ],
        ),
      );
    });
  }
}
