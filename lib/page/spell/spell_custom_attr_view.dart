import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_custom_attr_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SpellCustomAttrView extends StatefulWidget {
  final int spellId;

  const SpellCustomAttrView({super.key, required this.spellId});

  @override
  State<SpellCustomAttrView> createState() => _SpellCustomAttrViewState();
}

class _SpellCustomAttrViewState extends State<SpellCustomAttrView> {
  final viewModel = GetIt.instance.get<SpellCustomAttrViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(spellId: widget.spellId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final data = viewModel.customAttr.value;
      viewModel.initControllers(data);

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
                        child: FormItem(
                          controller: TextEditingController(
                            text: widget.spellId.toString(),
                          ),
                          label: '编号',
                          placeholder: 'spell_id',
                          readOnly: true,
                        ),
                      ),
                      Expanded(
                        child: FormItem(
                          label: '属性',
                          placeholder: 'attributes',
                          child: FoxyNumberInput<int>(
                            value: viewModel.attributes.value,
                            onChanged: (v) => viewModel.attributes.value = v,
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
                ShadButton(
                  onPressed: () => viewModel.save(context),
                  child: Text('保存'),
                ),
                ShadButton.ghost(
                  onPressed: () => viewModel.pop(),
                  child: Text('取消'),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
