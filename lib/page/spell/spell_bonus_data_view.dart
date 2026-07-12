import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_bonus_data_view_model.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SpellBonusDataView extends StatefulWidget {
  final int spellId;

  const SpellBonusDataView({super.key, required this.spellId});

  @override
  State<SpellBonusDataView> createState() => _SpellBonusDataViewState();
}

class _SpellBonusDataViewState extends State<SpellBonusDataView> {
  final viewModel = GetIt.instance.get<SpellBonusDataViewModel>();

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
      final data = viewModel.bonusData.value;
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
                        child: FoxyFormItem(
                          label: '编号',
                          child: FoxyNumberInput<int>(
                            controller: viewModel.spellIdController,
                            placeholder: 'entry',
                            readOnly: true,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FoxyFormItem(
                          label: '备注',
                          child: FoxyStringInput(
                            controller: viewModel.commentsController,
                            placeholder: 'comments',
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: FoxyFormItem(
                          label: '法术强度',
                          child: FoxyNumberInput<double>(
                            controller: viewModel.directBonusController,
                            placeholder: 'direct_bonus',
                          ),
                        ),
                      ),
                      Expanded(
                        child: FoxyFormItem(
                          label: '法术强度(dot)',
                          child: FoxyNumberInput<double>(
                            controller: viewModel.dotBonusController,
                            placeholder: 'dot_bonus',
                          ),
                        ),
                      ),
                      Expanded(
                        child: FoxyFormItem(
                          label: '攻击强度',
                          child: FoxyNumberInput<double>(
                            controller: viewModel.apBonusController,
                            placeholder: 'ap_bonus',
                          ),
                        ),
                      ),
                      Expanded(
                        child: FoxyFormItem(
                          label: '攻击强度(dot)',
                          child: FoxyNumberInput<double>(
                            controller: viewModel.apDotBonusController,
                            placeholder: 'ap_dot_bonus',
                          ),
                        ),
                      ),
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
