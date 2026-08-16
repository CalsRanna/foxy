import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/spell_bonus_data_linked_detail_view_model.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_string_input.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class SpellBonusDataView extends StatefulWidget {
  final int spellId;

  const SpellBonusDataView({super.key, required this.spellId});

  @override
  State<SpellBonusDataView> createState() => _SpellBonusDataViewState();
}

class _SpellBonusDataViewState extends State<SpellBonusDataView> {
  final viewModel = GetIt.instance.get<SpellBonusDataLinkedDetailViewModel>();

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
            if (viewModel.errorMessage.value != null)
              FoxyInlineError(message: viewModel.errorMessage.value),
            FoxyFormSection(
              title: '法术加成',
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: FoxyFormItem(
                        label: '编号',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.entryController,
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
                    const Expanded(child: SizedBox()),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                Row(
                  spacing: 8,
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
                        label: '法强（DOT）',
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
                        label: '攻强（DOT）',
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

  @override
  void didUpdateWidget(covariant SpellBonusDataView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.spellId != widget.spellId) {
      _initialize();
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _goBack() {
    GetIt.instance.get<RouterFacade>().goBack();
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(linkKey: widget.spellId);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }

  Future<void> _persist() async {
    try {
      await viewModel.persist();
      if (!mounted) return;
      DialogUtil.instance.success('奖励系数已保存');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('保存失败：${FoxyExceptions.message(error)}');
    }
  }
}
