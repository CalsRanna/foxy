import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_bonus_data_view_model.dart';
import 'package:foxy/widget/form_item.dart';
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
                        child: FormItem(
                          controller: TextEditingController(
                            text: widget.spellId.toString(),
                          ),
                          label: '编号',
                          placeholder: 'entry',
                          readOnly: true,
                        ),
                      ),
                      Expanded(
                        child: FormItem(
                          controller: viewModel.commentsController,
                          label: '备注',
                          placeholder: 'comments',
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
                        child: FormItem(
                          controller: viewModel.directBonusController,
                          label: '法术强度',
                          placeholder: 'direct_bonus',
                        ),
                      ),
                      Expanded(
                        child: FormItem(
                          controller: viewModel.dotBonusController,
                          label: '法术强度(dot)',
                          placeholder: 'dot_bonus',
                        ),
                      ),
                      Expanded(
                        child: FormItem(
                          controller: viewModel.apBonusController,
                          label: '攻击强度',
                          placeholder: 'ap_bonus',
                        ),
                      ),
                      Expanded(
                        child: FormItem(
                          controller: viewModel.apDotBonusController,
                          label: '攻击强度(dot)',
                          placeholder: 'ap_dot_bonus',
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
