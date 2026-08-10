import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/creature_on_kill_reputation_linked_detail_view_model.dart';
import 'package:foxy/widget/dialog/foxy_inline_error.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_form_item.dart';
import 'package:foxy/widget/foxy_form_section.dart';
import 'package:foxy/widget/foxy_number_input.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

/// On-kill reputation tab
class CreatureOnKillReputationView extends StatefulWidget {
  final int creatureId;

  const CreatureOnKillReputationView({super.key, required this.creatureId});

  @override
  State<CreatureOnKillReputationView> createState() =>
      _CreatureOnKillReputationViewState();
}

class _CreatureOnKillReputationViewState
    extends State<CreatureOnKillReputationView> {
  final viewModel = GetIt.instance
      .get<CreatureOnKillReputationLinkedDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return Watch(
      (_) => SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            if (viewModel.errorMessage.value != null)
              FoxyInlineError(message: viewModel.errorMessage.value),
            FoxyFormSection(
              title: '击杀声望',
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: FoxyFormItem(
                        label: '编号',
                        child: FoxyNumberInput<int>(
                          controller: viewModel.creatureIDController,
                          placeholder: 'creature_id',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '区分阵营',
                        child: FoxyShadSelect<int>(
                          controller: viewModel.teamDependentController,
                          options: CreatureEnums.booleanOptions,
                          placeholder: Text('TeamDependent'),
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
                        label: '阵营1',
                        child: FoxyEntityPicker(
                          delegate: FoxyEntityPickerDelegates.dbcFaction,
                          controller: viewModel.rewOnKillRepFaction1Controller,
                          placeholder: 'RewOnKillRepFaction1',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '阵营2',
                        child: FoxyEntityPicker(
                          delegate: FoxyEntityPickerDelegates.dbcFaction,
                          controller: viewModel.rewOnKillRepFaction2Controller,
                          placeholder: 'RewOnKillRepFaction2',
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
                        label: '声望值1',
                        child: FoxyNumberInput<double>(
                          controller: viewModel.rewOnKillRepValue1Controller,
                          placeholder: 'RewOnKillRepValue1',
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '声望值2',
                        child: FoxyNumberInput<double>(
                          controller: viewModel.rewOnKillRepValue2Controller,
                          placeholder: 'RewOnKillRepValue2',
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
                        label: '最高声望1',
                        child: FoxyShadSelect<int>(
                          controller: viewModel.maxStanding1Controller,
                          options: CreatureEnums.maxStandingOptions,
                          placeholder: Text('MaxStanding1'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '最高声望2',
                        child: FoxyShadSelect<int>(
                          controller: viewModel.maxStanding2Controller,
                          options: CreatureEnums.maxStandingOptions,
                          placeholder: Text('MaxStanding2'),
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
                        label: '包括声望组1',
                        child: FoxyShadSelect<int>(
                          controller: viewModel.isTeamAward1Controller,
                          options: CreatureEnums.booleanOptions,
                          placeholder: Text('IsTeamAward1'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FoxyFormItem(
                        label: '包括声望组2',
                        child: FoxyShadSelect<int>(
                          controller: viewModel.isTeamAward2Controller,
                          options: CreatureEnums.booleanOptions,
                          placeholder: Text('IsTeamAward2'),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    const Expanded(child: SizedBox()),
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
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CreatureOnKillReputationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.creatureId != widget.creatureId) {
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
      await viewModel.initSignals(linkKey: widget.creatureId);
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(FoxyError.message(error))));
    }
  }

  Future<void> _persist() async {
    try {
      await viewModel.persist();
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(const ShadToast(description: Text('击杀声望数据已保存')));
    } catch (error) {
      if (!mounted) return;
      ShadSonner.of(
        context,
      ).show(ShadToast(description: Text(FoxyError.message(error))));
    }
  }
}
