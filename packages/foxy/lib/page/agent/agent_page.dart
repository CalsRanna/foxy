import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/view_model/agent_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:get_it/get_it.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class AgentPage extends StatefulWidget {
  const AgentPage({super.key});

  @override
  State<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  final viewModel = GetIt.instance.get<AgentViewModel>();
  final scrollController = ScrollController();

  void Function()? _messageSubscription;

  @override
  Widget build(BuildContext context) {
    final divider = VerticalDivider(
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
      thickness: 1,
      width: 1,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: 260, child: _buildSessionList()),
        divider,
        Expanded(child: _buildWorkspace()),
      ],
    );
  }

  @override
  void dispose() {
    _messageSubscription?.call();
    scrollController.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    unawaited(viewModel.initSignals());
    _messageSubscription = viewModel.messages.subscribe(
      (_) => _scrollToBottom(),
    );
  }

  Widget _buildComposer() {
    return SignalBuilder(
      builder: (_) {
        final running = viewModel.running.value;
        final configured = viewModel.provider.value != null;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 8,
          children: [
            Expanded(
              child: ShadTextarea(
                controller: viewModel.draftController.controller,
                placeholder: const Text('输入问题，让 AI 查询 world 库和 foxy 库'),
                enabled: !running,
              ),
            ),
            if (running)
              ShadButton.outline(
                onPressed: viewModel.stop,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [Icon(LucideIcons.square, size: 15), Text('停止')],
                ),
              )
            else if (!configured)
              ShadButton.outline(
                onPressed: () => GetIt.instance
                    .get<RouterFacade>()
                    .navigateToMenu(RouterMenu.setting),
                child: const Text('前往设置'),
              )
            else
              ShadButton(
                onPressed: () => unawaited(viewModel.send()),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [Icon(LucideIcons.send, size: 15), Text('发送')],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildMessage(AgentChatMessage message) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = ShadTheme.of(context);
    switch (message.role) {
      case AgentChatRole.user:
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
              message.text,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        );
      case AgentChatRole.assistant:
        final text = message.text.isEmpty
            ? (viewModel.running.value ? '思考中...' : '（无回复）')
            : message.text;
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SelectionArea(
            child: GptMarkdown(
              text,
              style: const TextStyle(fontSize: 13, height: 1.5),
            ),
          ),
        );
      case AgentChatRole.tool:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            spacing: 6,
            children: [
              Icon(
                LucideIcons.wrench,
                size: 13,
                color: theme.colorScheme.mutedForeground,
              ),
              Expanded(
                child: Text(
                  message.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.muted.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildMessageList() {
    final theme = ShadTheme.of(context);
    return SignalBuilder(
      builder: (_) {
        final messages = viewModel.messages.value;
        if (messages.isEmpty) {
          final hint = viewModel.provider.value == null
              ? '尚未配置模型服务商，请前往「设置 → AI 助手」'
              : '输入问题，让 AI 查询 world 库和 foxy 库';
          return Center(child: Text(hint, style: theme.textTheme.muted));
        }
        return ListView.builder(
          controller: scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) => _buildMessage(messages[index]),
        );
      },
    );
  }

  Widget _buildSessionList() {
    final header = Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 12, 8),
      child: Row(
        children: [
          const Text(
            '会话',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          ShadButton.ghost(
            size: ShadButtonSize.sm,
            onPressed: () => unawaited(viewModel.createSession()),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: [
                Icon(LucideIcons.messageSquarePlus, size: 15),
                Text('新建'),
              ],
            ),
          ),
        ],
      ),
    );
    final list = Expanded(
      child: SignalBuilder(
        builder: (_) {
          final sessions = viewModel.sessions.value;
          final activeId = viewModel.activeSessionId.value;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return _buildSessionTile(session, session.id == activeId);
            },
          );
        },
      ),
    );
    return Column(children: [header, list]);
  }

  Widget _buildSessionTile(AgentChatSessionMeta meta, bool active) {
    final colorScheme = Theme.of(context).colorScheme;
    final background = active ? colorScheme.primary : Colors.transparent;
    final foreground = active ? colorScheme.onPrimary : colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () => unawaited(viewModel.selectSession(meta.id)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              spacing: 6,
              children: [
                Expanded(
                  child: Text(
                    meta.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: foreground),
                  ),
                ),
                InkWell(
                  onTap: () => unawaited(_confirmDelete(meta)),
                  child: Icon(
                    LucideIcons.trash2,
                    size: 14,
                    color: foreground.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkspace() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          _buildWorkspaceHeader(),
          Expanded(child: _buildMessageList()),
          _buildComposer(),
        ],
      ),
    );
  }

  Widget _buildWorkspaceHeader() {
    final theme = ShadTheme.of(context);
    return SignalBuilder(
      builder: (_) {
        final provider = viewModel.provider.value;
        return Row(
          spacing: 8,
          children: [
            const Icon(LucideIcons.astroid, size: 18),
            Expanded(
              child: Text(
                viewModel.activeTitle ?? 'AI 助手',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              provider?.model ?? '未配置模型',
              style: theme.textTheme.muted.copyWith(fontSize: 12),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDelete(AgentChatSessionMeta meta) async {
    final confirmed = await DialogUtil.instance.confirm(
      title: '删除会话',
      description: '确定删除「${meta.title}」吗？',
      confirmText: '删除',
      destructive: true,
    );
    if (!confirmed) return;
    try {
      await viewModel.deleteSession(meta.id);
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('删除会话失败：${FoxyExceptions.message(error)}');
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }
}
