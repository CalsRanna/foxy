import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/page/skill_line/skill_line_ability_view.dart';
import 'package:foxy/page/skill_line/skill_line_view.dart';
import 'package:foxy/view_model/skill_line_detail_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_tab.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class SkillLineDetailPage extends StatefulWidget {
  final int? skillLineKey;

  const SkillLineDetailPage({super.key, this.skillLineKey});

  @override
  State<SkillLineDetailPage> createState() => _SkillLineDetailPageState();
}

class _SkillLineDetailPageState extends State<SkillLineDetailPage> {
  final viewModel = GetIt.instance.get<SkillLineDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FoxyHeader('专业技能详情'),
        ),
        Watch((_) {
          final key = viewModel.persistedKey.value;
          final skillLineId = key ?? 0;
          return FoxyTab(
            tabs: const [Text('基本信息'), Text('技能能力')],
            contents: [
              SkillLineView(viewModel: viewModel),
              SkillLineAbilityView(
                key: ValueKey('ability-$skillLineId'),
                skillLineId: skillLineId,
              ),
            ],
            disabledIndexes: key == null ? const {1} : const {},
          );
        }),
      ],
    );
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

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals(key: widget.skillLineKey);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载失败：${FoxyExceptions.message(error)}');
    }
  }
}
