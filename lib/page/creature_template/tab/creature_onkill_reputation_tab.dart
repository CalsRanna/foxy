import 'package:flutter/material.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/model/creature_onkill_reputation.dart';
import 'package:foxy/repository/creature_onkill_reputation_repository.dart';
import 'package:foxy/widget/form_item.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 击杀声望Tab
class CreatureOnkillReputationTab extends StatefulWidget {
  final int creatureID;

  const CreatureOnkillReputationTab({super.key, required this.creatureID});

  @override
  State<CreatureOnkillReputationTab> createState() => _CreatureOnkillReputationTabState();
}

class _CreatureOnkillReputationTabState extends State<CreatureOnkillReputationTab> {
  final _repository = CreatureOnkillReputationRepository();
  CreatureOnkillReputation? _rep;
  bool _loading = true;

  // 表单控制器
  final _rewOnKillRepFaction1Controller = TextEditingController();
  final _rewOnKillRepFaction2Controller = TextEditingController();
  final _maxStanding1Controller = TextEditingController();
  final _maxStanding2Controller = TextEditingController();
  final _isTeamAward1Controller = ShadSelectController<int>();
  final _isTeamAward2Controller = ShadSelectController<int>();
  final _rewOnKillRepValue1Controller = TextEditingController();
  final _rewOnKillRepValue2Controller = TextEditingController();
  final _teamDependentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _rewOnKillRepFaction1Controller.dispose();
    _rewOnKillRepFaction2Controller.dispose();
    _maxStanding1Controller.dispose();
    _maxStanding2Controller.dispose();
    _isTeamAward1Controller.dispose();
    _isTeamAward2Controller.dispose();
    _rewOnKillRepValue1Controller.dispose();
    _rewOnKillRepValue2Controller.dispose();
    _teamDependentController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final rep = await _repository.getByEntry(widget.creatureID);
      if (mounted) {
        setState(() {
          _rep = rep;
          if (rep != null) {
            _fillForm(rep);
          } else {
            _resetForm();
          }
        });
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _resetForm() {
    _rewOnKillRepFaction1Controller.text = '0';
    _rewOnKillRepFaction2Controller.text = '0';
    _maxStanding1Controller.text = '0';
    _maxStanding2Controller.text = '0';
    _isTeamAward1Controller.value = {0};
    _isTeamAward2Controller.value = {0};
    _rewOnKillRepValue1Controller.text = '0';
    _rewOnKillRepValue2Controller.text = '0';
    _teamDependentController.text = '0';
  }

  void _fillForm(CreatureOnkillReputation rep) {
    _rewOnKillRepFaction1Controller.text = rep.rewOnKillRepFaction1.toString();
    _rewOnKillRepFaction2Controller.text = rep.rewOnKillRepFaction2.toString();
    _maxStanding1Controller.text = rep.maxStanding1.toString();
    _maxStanding2Controller.text = rep.maxStanding2.toString();
    _isTeamAward1Controller.value = {rep.isTeamAward1 ? 1 : 0};
    _isTeamAward2Controller.value = {rep.isTeamAward2 ? 1 : 0};
    _rewOnKillRepValue1Controller.text = rep.rewOnKillRepValue1.toString();
    _rewOnKillRepValue2Controller.text = rep.rewOnKillRepValue2.toString();
    _teamDependentController.text = rep.teamDependent.toString();
  }

  CreatureOnkillReputation _collectFromForm() {
    final rep = CreatureOnkillReputation();
    rep.creatureID = widget.creatureID;
    rep.rewOnKillRepFaction1 = int.tryParse(_rewOnKillRepFaction1Controller.text) ?? 0;
    rep.rewOnKillRepFaction2 = int.tryParse(_rewOnKillRepFaction2Controller.text) ?? 0;
    rep.maxStanding1 = int.tryParse(_maxStanding1Controller.text) ?? 0;
    rep.maxStanding2 = int.tryParse(_maxStanding2Controller.text) ?? 0;
    rep.isTeamAward1 = _isTeamAward1Controller.value.first == 1;
    rep.isTeamAward2 = _isTeamAward2Controller.value.first == 1;
    rep.rewOnKillRepValue1 = int.tryParse(_rewOnKillRepValue1Controller.text) ?? 0;
    rep.rewOnKillRepValue2 = int.tryParse(_rewOnKillRepValue2Controller.text) ?? 0;
    rep.teamDependent = int.tryParse(_teamDependentController.text) ?? 0;
    return rep;
  }

  Future<void> _save() async {
    try {
      final rep = _collectFromForm();
      await _repository.save(rep);
      await _load();
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast(title: Text('保存成功')),
        );
      }
    } catch (e) {
      if (mounted) {
        ShadToaster.of(context).show(
          ShadToast.destructive(title: Text('保存失败'), description: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: EdgeInsets.all(16),
      child: ShadCard(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text('击杀声望奖励',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Column(
                    spacing: 12,
                    children: [
                      Text('阵营1',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      FormItem(
                        controller: _rewOnKillRepFaction1Controller,
                        label: '阵营ID',
                        placeholder: 'RewOnKillRepFaction1',
                      ),
                      FormItem(
                        controller: _maxStanding1Controller,
                        label: '最高声望',
                        placeholder: 'MaxStanding1',
                      ),
                      FormItem(
                        label: '团队奖励',
                        child: FoxyShadSelect<int>(
                          controller: _isTeamAward1Controller,
                          options: kBooleanOptions,
                          placeholder: Text('IsTeamAward1'),
                        ),
                      ),
                      FormItem(
                        controller: _rewOnKillRepValue1Controller,
                        label: '声望值',
                        placeholder: 'RewOnKillRepValue1',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    spacing: 12,
                    children: [
                      Text('阵营2',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      FormItem(
                        controller: _rewOnKillRepFaction2Controller,
                        label: '阵营ID',
                        placeholder: 'RewOnKillRepFaction2',
                      ),
                      FormItem(
                        controller: _maxStanding2Controller,
                        label: '最高声望',
                        placeholder: 'MaxStanding2',
                      ),
                      FormItem(
                        label: '团队奖励',
                        child: FoxyShadSelect<int>(
                          controller: _isTeamAward2Controller,
                          options: kBooleanOptions,
                          placeholder: Text('IsTeamAward2'),
                        ),
                      ),
                      FormItem(
                        controller: _rewOnKillRepValue2Controller,
                        label: '声望值',
                        placeholder: 'RewOnKillRepValue2',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FormItem(
              controller: _teamDependentController,
              label: '团队依赖',
              placeholder: 'TeamDependent',
            ),
            SizedBox(height: 8),
            ShadButton(onPressed: _save, child: Text('保存')),
          ],
        ),
      ),
    );
  }
}
