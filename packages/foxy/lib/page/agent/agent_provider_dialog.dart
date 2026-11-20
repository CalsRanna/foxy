import 'package:flutter/material.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/dialog/setting_dialog_shell.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Provider settings form for the AI agent page.
///
/// Pops with the submitted [AgentProviderConfig], or `null` when cancelled;
/// persistence and error display stay with the page.
class AgentProviderDialog extends StatefulWidget {
  final AgentProviderConfig? initial;

  const AgentProviderDialog({super.key, this.initial});

  @override
  State<AgentProviderDialog> createState() => _AgentProviderDialogState();
}

class _AgentProviderDialogState extends State<AgentProviderDialog> {
  late final _baseUrlController = TextEditingController(
    text: widget.initial?.baseUrl ?? '',
  );
  late final _modelController = TextEditingController(
    text: widget.initial?.model ?? '',
  );
  late final _apiKeyController = TextEditingController(
    text: widget.initial?.apiKey ?? '',
  );

  @override
  Widget build(BuildContext context) {
    return SettingDialogShell(
      title: SettingDialogShell.titleRow(LucideIcons.bot, '模型服务商'),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        ShadButton(onPressed: _submit, child: const Text('保存')),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          SettingDialogShell.mutedHint(
            context,
            '支持任意兼容 Responses 协议的服务商，请求发往 {Base URL}/responses。',
          ),
          ShadInput(
            controller: _baseUrlController,
            placeholder: const Text('Base URL，例如 https://api.openai.com/v1'),
          ),
          ShadInput(
            controller: _modelController,
            placeholder: const Text('模型名称'),
          ),
          ShadInput(
            controller: _apiKeyController,
            placeholder: const Text('API Key（本地服务可留空）'),
            obscureText: true,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _baseUrlController.dispose();
    _modelController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  void _submit() {
    final baseUrl = _baseUrlController.text.trim();
    final model = _modelController.text.trim();
    if (baseUrl.isEmpty || model.isEmpty) {
      DialogUtil.instance.error('请填写 Base URL 和模型名称');
      return;
    }
    Navigator.of(context).pop(
      AgentProviderConfig(
        baseUrl: baseUrl,
        apiKey: _apiKeyController.text.trim(),
        model: model,
      ),
    );
  }
}
