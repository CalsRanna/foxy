import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/page/creature_template/creature_on_kill_reputation_view_model.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

/// 击杀声望Tab
class CreatureOnKillReputationView extends StatefulWidget {
  final int creatureID;

  const CreatureOnKillReputationView({super.key, required this.creatureID});

  @override
  State<CreatureOnKillReputationView> createState() =>
      _CreatureOnKillReputationViewState();
}

class _CreatureOnKillReputationViewState
    extends State<CreatureOnKillReputationView> {
  final viewModel = GetIt.instance.get<CreatureOnKillReputationViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals(entryId: widget.creatureID);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      // 监听数据变化，当数据更新时自动更新控件
      final repData = viewModel.reputation.value;
      viewModel.initControllers(repData);

      if (viewModel.loading.value) {
        return Center(child: CircularProgressIndicator());
      }

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
                          controller: viewModel.creatureIdController,
                          label: '编号',
                          placeholder: 'creature_id',
                          readOnly: true,
                        ),
                      ),
                      Expanded(
                        child: FormItem(
                          controller: viewModel.teamDependentController,
                          label: '区分阵营',
                          placeholder: 'TeamDependent',
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: FormItem(
                          controller: viewModel.rewOnKillRepFaction1Controller,
                          label: '阵营1',
                          placeholder: 'RewOnKillRepFaction1',
                        ),
                      ),
                      Expanded(
                        child: FormItem(
                          controller: viewModel.rewOnKillRepFaction2Controller,
                          label: '阵营2',
                          placeholder: 'RewOnKillRepFaction2',
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: FormItem(
                          controller: viewModel.rewOnKillRepValue1Controller,
                          label: '声望值1',
                          placeholder: 'RewOnKillRepValue1',
                        ),
                      ),
                      Expanded(
                        child: FormItem(
                          controller: viewModel.rewOnKillRepValue2Controller,
                          label: '声望值2',
                          placeholder: 'RewOnKillRepValue2',
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: FormItem(
                          label: '最高声望等级1',
                          child: FoxyShadSelect<int>(
                            controller: viewModel.maxStanding1Controller,
                            options: kMaxStandingOptions,
                            placeholder: Text('MaxStanding1'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FormItem(
                          label: '最高声望等级2',
                          child: FoxyShadSelect<int>(
                            controller: viewModel.maxStanding2Controller,
                            options: kMaxStandingOptions,
                            placeholder: Text('MaxStanding2'),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: FormItem(
                          label: '包括声望组1',
                          child: FoxyShadSelect<int>(
                            controller: viewModel.isTeamAward1Controller,
                            options: kBooleanOptions,
                            placeholder: Text('IsTeamAward1'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FormItem(
                          label: '包括声望组2',
                          child: FoxyShadSelect<int>(
                            controller: viewModel.isTeamAward2Controller,
                            options: kBooleanOptions,
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
