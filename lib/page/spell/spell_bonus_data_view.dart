import 'package:flutter/material.dart';
import 'package:foxy/page/spell/spell_bonus_data_single_editor_view_model.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:signals/signals_flutter.dart';

class SpellBonusDataView extends StatefulWidget {
  final int spellId;

  const SpellBonusDataView({super.key, required this.spellId});

  @override
  State<SpellBonusDataView> createState() => _SpellBonusDataViewState();
}

class _SpellBonusDataViewState extends State<SpellBonusDataView> {
  final viewModel = GetIt.instance.get<SpellBonusDataSingleEditorViewModel>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant SpellBonusDataView oldWidget) {
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
      ).show(const ShadToast(description: Text('奖励系数已保存')));
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
                            placeholder: 'entry',
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
