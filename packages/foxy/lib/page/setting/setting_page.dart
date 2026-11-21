import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/page/setting/agent_provider_dialog.dart';
import 'package:foxy/page/setting/combined_export_dialog.dart';
import 'package:foxy/page/setting/dbc_export_dialog.dart';
import 'package:foxy/page/setting/dbc_import_dialog.dart';
import 'package:foxy/page/setting/icon_extract_dialog.dart';
import 'package:foxy/page/setting/mpq_export_dialog.dart';
import 'package:foxy/router/setting_entry.dart';
import 'package:foxy/router/setting_section.dart';
import 'package:foxy/use_case/agent/agent_provider_config_use_case.dart';
import 'package:foxy/view_model/foxy_state_view_model.dart';
import 'package:foxy/view_model/setup_status_view_model.dart';
import 'package:foxy/view_model/update_view_model.dart';
import 'package:foxy/view_model/workflow/combined_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_export_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/dbc_import_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/icon_extract_workflow_view_model.dart';
import 'package:foxy/view_model/workflow/mpq_export_workflow_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/directory/directory_setting_row.dart';
import 'package:foxy/widget/update/update_dialog.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SettingPage extends StatefulWidget {
  final SettingSection initialSection;

  const SettingPage({
    super.key,
    this.initialSection = SettingSection.environment,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingGroup extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const _SettingGroup({this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final divider = Divider(
      height: 1,
      thickness: 1,
      color: theme.colorScheme.border,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title case final title?)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Semantics(
              header: true,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        divider,
        ...children.expand(
          (child) => [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: child,
            ),
            divider,
          ],
        ),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String title;
  final String description;
  final Widget trailing;

  const _SettingItem({
    required this.title,
    required this.description,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(
                description,
                style: theme.textTheme.muted.copyWith(
                  color: theme.colorScheme.mutedForeground,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        trailing,
      ],
    );
  }
}

class _SettingPageState extends State<SettingPage> {
  static const _titleStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  final stateViewModel = GetIt.instance.get<FoxyStateViewModel>();
  late SettingSection _section = widget.initialSection;
  bool _editingAgentProvider = false;
  bool _savingLocale = false;
  final agentProviderConfig = GetIt.instance.get<AgentProviderConfigUseCase>();
  final setupViewModel = GetIt.instance.get<SetupStatusViewModel>();
  final importViewModel = GetIt.instance.get<DbcImportWorkflowViewModel>();
  final exportViewModel = GetIt.instance.get<DbcExportWorkflowViewModel>();
  final mpqViewModel = GetIt.instance.get<MpqExportWorkflowViewModel>();
  final combinedViewModel = GetIt.instance
      .get<CombinedExportWorkflowViewModel>();
  final iconViewModel = GetIt.instance.get<IconExtractWorkflowViewModel>();
  final updateViewModel = GetIt.instance.get<UpdateViewModel>();

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 208,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                  child: Semantics(
                    header: true,
                    child: const Text('设置', style: _titleStyle),
                  ),
                ),
                ...SettingSection.values.map(_buildSectionButton),
              ],
            ),
          ),
        ),
        VerticalDivider(width: 1, thickness: 1, color: colors.border),
        Expanded(
          child: SingleChildScrollView(
            key: ValueKey(_section),
            padding: const EdgeInsets.fromLTRB(48, 30, 48, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 28,
              children: [
                Semantics(
                  header: true,
                  child: Text(_section.label, style: _titleStyle),
                ),
                switch (_section) {
                  SettingSection.environment => _buildEnvironmentSection(),
                  SettingSection.data => _buildDataSection(),
                  SettingSection.preferences => _buildPreferencesSection(),
                  SettingSection.about => _buildUpdateSection(),
                },
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant SettingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSection != oldWidget.initialSection) {
      _section = widget.initialSection;
    }
  }

  @override
  void dispose() {
    exportViewModel.dispose();
    mpqViewModel.dispose();
    combinedViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setupViewModel.prepare();
    updateViewModel.prepare();
  }

  Widget _buildDataSection() {
    return SignalBuilder(
      builder: (_) {
        // Read every workflow before combining the values so SignalBuilder
        // continues tracking all four workflows while one is busy.
        final importBusy = importViewModel.isRunning;
        final exportBusy = exportViewModel.isRunning;
        final mpqBusy = mpqViewModel.isRunning;
        final combinedBusy = combinedViewModel.isRunning;
        final busy = importBusy || exportBusy || mpqBusy || combinedBusy;
        final theme = ShadTheme.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 28,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.muted.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: theme.colorScheme.border),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: _SettingItem(
                  title: SettingEntry.combinedExport.title,
                  description: '读取一次数据库，生成服务端 DBC 文件和客户端 MPQ 补丁。',
                  trailing: ShadButton(
                    onPressed: busy ? null : _showCombinedExportDialog,
                    child: Text(SettingEntry.combinedExport.actionLabel),
                  ),
                ),
              ),
            ),
            _SettingGroup(
              title: '单独导入或导出',
              children: [
                _SettingItem(
                  title: SettingEntry.dbcImport.title,
                  description: '从服务端目录读取 DBC 文件，覆盖 Foxy 数据库中的对应表。',
                  trailing: ShadButton.outline(
                    size: ShadButtonSize.sm,
                    onPressed: busy ? null : _showImportDialog,
                    child: Text(SettingEntry.dbcImport.actionLabel),
                  ),
                ),
                _SettingItem(
                  title: SettingEntry.dbcExport.title,
                  description: '将选中的数据库表导出到服务端 DBC 目录。',
                  trailing: ShadButton.outline(
                    size: ShadButtonSize.sm,
                    onPressed: busy ? null : _showExportDialog,
                    child: Text(SettingEntry.dbcExport.actionLabel),
                  ),
                ),
                _SettingItem(
                  title: SettingEntry.mpqExport.title,
                  description: '将选中的 DBC 表打包到客户端 MPQ 归档目录。',
                  trailing: ShadButton.outline(
                    size: ShadButtonSize.sm,
                    onPressed: busy ? null : _showMpqExportDialog,
                    child: Text(SettingEntry.mpqExport.actionLabel),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildEnvironmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 24,
      children: [
        _SettingGroup(
          title: DirectoryConfigTarget.groupLabel,
          children: [
            DirectorySettingRow(
              vm: setupViewModel,
              target: DirectoryConfigTarget.clientDir,
            ),
            DirectorySettingRow(
              vm: setupViewModel,
              target: DirectoryConfigTarget.serverDir,
            ),
          ],
        ),
        _buildIconSection(),
      ],
    );
  }

  Widget _buildIconSection() {
    return SignalBuilder(
      builder: (_) => _SettingGroup(
        title: '游戏图标',
        children: [
          _SettingItem(
            title: SettingEntry.iconExtract.title,
            description: '从客户端 MPQ 归档提取图标，用于游戏数据列表。',
            trailing: ShadButton.outline(
              size: ShadButtonSize.sm,
              onPressed: iconViewModel.isRunning
                  ? null
                  : _showIconExtractDialog,
              child: Text(SettingEntry.iconExtract.actionLabel),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return _SettingGroup(
      children: [
        SignalBuilder(
          builder: (_) {
            final hasLocaleTables = stateViewModel.hasLocaleTables.value;
            return _SettingItem(
              title: SettingEntry.localeTables.title,
              description: hasLocaleTables
                  ? '优先显示本地化表中的文本，下次查询生效。'
                  : '当前数据库未检测到本地化表。',
              trailing: ShadSwitch(
                value: stateViewModel.localeEnabled.value,
                enabled: hasLocaleTables && !_savingLocale,
                onChanged: _setLocaleEnabled,
              ),
            );
          },
        ),
        _SettingItem(
          title: SettingEntry.aiModel.title,
          description: '设置模型服务商的 Base URL、模型名称和 API Key。',
          trailing: ShadButton.outline(
            size: ShadButtonSize.sm,
            onPressed: _editingAgentProvider ? null : _showAgentProviderDialog,
            child: Text(SettingEntry.aiModel.actionLabel),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionButton(SettingSection section) {
    final colors = ShadTheme.of(context).colorScheme;
    final selected = section == _section;
    final icon = switch (section) {
      SettingSection.environment => LucideIcons.folders,
      SettingSection.data => LucideIcons.database,
      SettingSection.preferences => LucideIcons.slidersHorizontal,
      SettingSection.about => LucideIcons.info,
    };
    return Semantics(
      selected: selected,
      child: ShadButton.ghost(
        width: double.infinity,
        expands: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        backgroundColor: selected ? colors.muted : null,
        foregroundColor: selected ? colors.foreground : colors.mutedForeground,
        onPressed: () => setState(() => _section = section),
        child: Row(
          spacing: 10,
          children: [
            Icon(icon, size: 17),
            Expanded(
              child: Text(
                section.label,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateSection() {
    return _SettingGroup(
      children: [
        SignalBuilder(
          builder: (_) {
            final version = updateViewModel.currentVersion.value;
            return _SettingItem(
              title: SettingEntry.appUpdates.title,
              description: version == null ? '应用更新' : '当前版本 $version',
              trailing: ShadButton.outline(
                size: ShadButtonSize.sm,
                onPressed: _showUpdateDialog,
                child: Text(SettingEntry.appUpdates.actionLabel),
              ),
            );
          },
        ),
        _SettingItem(
          title: SettingEntry.projectPage.title,
          description: '在 GitHub 查看文档、更新记录和问题反馈。',
          trailing: ShadButton.outline(
            size: ShadButtonSize.sm,
            onPressed: _openProjectPage,
            child: Text(SettingEntry.projectPage.actionLabel),
          ),
        ),
      ],
    );
  }

  Future<void> _openProjectPage() async {
    final ok = await launchUrl(
      Uri.parse('https://github.com/CalsRanna/foxy'),
      mode: LaunchMode.externalApplication,
    );
    if (!ok) {
      DialogUtil.instance.error('无法打开项目主页');
    }
  }

  Future<void> _setLocaleEnabled(bool enabled) async {
    setState(() => _savingLocale = true);
    try {
      await GetIt.instance.get<ConfigUtil>().update({
        'locale_enabled': enabled,
      });
      stateViewModel.setLocaleSettings(
        hasLocaleTables: stateViewModel.hasLocaleTables.value,
        localeEnabled: enabled,
      );
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('保存本地化设置失败：${FoxyExceptions.message(error)}');
    } finally {
      if (mounted) setState(() => _savingLocale = false);
    }
  }

  Future<void> _showAgentProviderDialog() async {
    setState(() => _editingAgentProvider = true);
    try {
      final initial = await agentProviderConfig.load();
      if (!mounted) return;
      final config = await DialogUtil.show<AgentProviderConfig>(
        context: context,
        builder: (context) => AgentProviderDialog(initial: initial),
      );
      if (config == null || !mounted) return;
      await agentProviderConfig.save(config);
      if (!mounted) return;
      DialogUtil.instance.success('模型服务商配置已保存');
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('模型服务商配置失败：${FoxyExceptions.message(error)}');
    } finally {
      if (mounted) setState(() => _editingAgentProvider = false);
    }
  }

  void _showCombinedExportDialog() {
    DialogUtil.show(
      context: context,
      barrierDismissible: false,
      builder: (context) => CombinedExportDialog(vm: combinedViewModel),
    );
  }

  void _showExportDialog() {
    DialogUtil.show(
      context: context,
      barrierDismissible: false,
      builder: (context) => DbcExportDialog(vm: exportViewModel),
    );
  }

  void _showIconExtractDialog() {
    DialogUtil.show(
      context: context,
      barrierDismissible: false,
      builder: (context) => IconExtractDialog(vm: iconViewModel),
    );
  }

  void _showImportDialog() {
    DialogUtil.show(
      context: context,
      barrierDismissible: false,
      builder: (context) => DbcImportDialog(vm: importViewModel),
    );
  }

  void _showMpqExportDialog() {
    DialogUtil.show(
      context: context,
      barrierDismissible: false,
      builder: (context) => MpqExportDialog(vm: mpqViewModel),
    );
  }

  /// Triggers the manual check first (the signal enters "checking" state
  /// synchronously), then opens a dialog that live-updates with the state.
  void _showUpdateDialog() {
    updateViewModel.checkManually();
    DialogUtil.show(
      context: context,
      barrierDismissible: false,
      builder: (context) => UpdateDialog(vm: updateViewModel),
    );
  }
}
