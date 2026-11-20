import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';
import 'package:foxy/page/agent/agent_composer.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/setting_section.dart';
import 'package:foxy/view_model/agent_view_model.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy_widget/foxy_widget.dart';
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
  static const _toolCallPrefix = '调用 ';
  static const _toolFailurePrefix = '工具失败：';

  final viewModel = GetIt.instance.get<AgentViewModel>();
  final scrollController = ScrollController();
  late final _followingBottom = ValueNotifier(true);
  late final _composerFocus = FocusNode();

  void Function()? _messageSubscription;
  String? _displayedSessionId;
  late bool _scrollScheduled = false;
  var _newSessionHovered = false;
  String? _hoveredSessionId;

  bool get _isMac => Theme.of(context).platform == TargetPlatform.macOS;

  @override
  Widget build(BuildContext context) {
    final divider = VerticalDivider(
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
      thickness: 1,
      width: 1,
    );
    return CallbackShortcuts(
      bindings: {
        SingleActivator(
          LogicalKeyboardKey.keyN,
          meta: _isMac,
          control: !_isMac,
          includeRepeats: false,
        ): _startNewSession,
      },
      child: FocusScope(
        autofocus: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 260, child: _buildSessionList()),
            divider,
            Expanded(child: _buildWorkspace()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageSubscription?.call();
    _followingBottom.dispose();
    _composerFocus.dispose();
    scrollController.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    unawaited(viewModel.initSignals());
    _messageSubscription = viewModel.messages.subscribe((_) {
      final sessionId = viewModel.activeSessionId.peek();
      if (_displayedSessionId != sessionId) {
        _displayedSessionId = sessionId;
        _followingBottom.value = true;
      }
      _scrollToBottom();
    });
  }

  Widget _buildComposer() {
    return SignalBuilder(
      builder: (_) => AgentComposer(
        controller: viewModel.draftController.controller,
        focusNode: _composerFocus,
        running: viewModel.running.value,
        configured: viewModel.provider.value != null,
        ready: viewModel.ready.value,
        onSend: () {
          _followBottom();
          unawaited(viewModel.send());
        },
        onStop: viewModel.stop,
        onConfigure: () => GetIt.instance
            .get<RouterFacade>()
            .navigateToSettings(SettingSection.preferences),
      ),
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
        if (message.text.isEmpty && viewModel.running.value) {
          return _buildStepStatus('思考中', thinking: true);
        }
        final text = message.text.isEmpty ? '（无回复）' : message.text;
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
      case AgentChatRole.reasoning:
        return SelectionArea(
          child: GptMarkdown(message.text, style: theme.textTheme.muted),
        );
      case AgentChatRole.tool:
        if (viewModel.isToolInProgress(message)) {
          return _buildStepStatus(
            message.text,
            thinking: false,
            runningTool: true,
            icon: LucideIcons.wrench,
          );
        }
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

  Widget _buildMessageGroup(List<AgentChatMessage> group) {
    if (group.length == 1) {
      final message = group.single;
      return message.role == AgentChatRole.reasoning
          ? _buildReasoningStep(message, nested: false)
          : _buildMessage(message);
    }

    // Calls and failures share the same role in saved sessions.
    final tools = group.where((message) => message.role == AgentChatRole.tool);
    final callCount = tools
        .where((message) => message.text.startsWith(_toolCallPrefix))
        .length;
    final hasReasoning = group.any(
      (message) => message.role == AgentChatRole.reasoning,
    );
    if (!hasReasoning && callCount < 2) {
      return Column(children: group.map(_buildMessage).toList());
    }

    final thinking = group.any(viewModel.isReasoningInProgress);
    final runningTool = tools.any(viewModel.isToolInProgress);
    final failureCount = tools
        .where((message) => message.text.startsWith(_toolFailurePrefix))
        .length;
    final failureSummary = failureCount == 0 ? '' : '，$failureCount 次失败';
    final label = [
      if (thinking)
        '思考中'
      else if (runningTool)
        '工具执行中'
      else if (hasReasoning)
        '推理过程',
      if (callCount > 0) '工具调用（$callCount 次$failureSummary）',
    ].join(' · ');
    return _AgentStepAccordion(
      key: PageStorageKey((group.first, true)),
      title: _buildStepStatus(
        label,
        thinking: thinking,
        runningTool: runningTool,
        accordionTitle: true,
        icon: callCount > 0 ? LucideIcons.wrench : LucideIcons.brain,
      ),
      children: [
        for (final message in group)
          if (message.role == AgentChatRole.reasoning)
            _buildReasoningStep(message, nested: true)
          else
            _buildToolStep(message),
      ],
    );
  }

  Widget _buildMessageList() {
    final theme = ShadTheme.of(context);
    return SignalBuilder(
      builder: (_) {
        final messages = viewModel.messages.value;
        if (messages.isEmpty) {
          final hint = viewModel.provider.value == null
              ? '尚未配置模型服务商，请前往「设置 → 编辑偏好」'
              : '输入问题，让 AI 查询 world 库和 foxy 库';
          return Center(child: Text(hint, style: theme.textTheme.muted));
        }
        final groups = <List<AgentChatMessage>>[];
        for (final message in messages) {
          if (_isStep(message) &&
              groups.isNotEmpty &&
              _isStep(groups.last.first)) {
            groups.last.add(message);
          } else {
            groups.add([message]);
          }
        }
        return Stack(
          children: [
            Positioned.fill(
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  if (notification.depth == 0) {
                    _followingBottom.value =
                        notification.metrics.extentAfter <= 1;
                  }
                  return false;
                },
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: groups.length,
                  itemBuilder: (context, index) =>
                      _buildMessageGroup(groups[index]),
                ),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: ValueListenableBuilder<bool>(
                valueListenable: _followingBottom,
                builder: (context, following, _) => following
                    ? const SizedBox.shrink()
                    : IconButton.filledTonal(
                        tooltip: '回到底部',
                        onPressed: _followBottom,
                        icon: const Icon(LucideIcons.arrowDown, size: 16),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReasoningStep(AgentChatMessage message, {required bool nested}) {
    final thinking = viewModel.isReasoningInProgress(message);
    return _AgentStepAccordion(
      key: PageStorageKey((message, false)),
      title: _buildStepStatus(
        thinking ? '思考中' : '推理过程',
        thinking: thinking && !nested,
        accordionTitle: true,
      ),
      children: [
        if (message.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildMessage(message),
          ),
      ],
    );
  }

  Widget _buildSessionList() {
    final theme = ShadTheme.of(context);
    final header = Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: ShadButton.ghost(
        width: double.infinity,
        expands: true,
        size: ShadButtonSize.sm,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        foregroundColor: theme.colorScheme.foreground,
        onPressed: _startNewSession,
        onHoverChange: (hovered) =>
            setState(() => _newSessionHovered = hovered),
        child: Row(
          spacing: 8,
          children: [
            const Icon(LucideIcons.squarePen, size: 15),
            const Expanded(child: Text('新建会话', textAlign: TextAlign.left)),
            if (_newSessionHovered)
              Text(
                _isMac ? '⌘N' : 'Ctrl+N',
                style: theme.textTheme.muted.copyWith(fontSize: 11),
              ),
          ],
        ),
      ),
    );
    final list = Expanded(
      child: SignalBuilder(
        builder: (_) {
          final sessions = viewModel.sessions.value;
          final activeId = viewModel.activeSessionId.value;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            itemCount: sessions.isEmpty ? 0 : sessions.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
                  child: Text(
                    '会话',
                    style: theme.textTheme.muted.copyWith(fontSize: 12),
                  ),
                );
              }
              final session = sessions[index - 1];
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
    final foreground = active ? colorScheme.onPrimary : colorScheme.onSurface;
    return Padding(
      key: ValueKey(meta.id),
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ShadButton.ghost(
        width: double.infinity,
        height: 0,
        expands: true,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        backgroundColor: active ? colorScheme.primary : null,
        hoverBackgroundColor: active
            ? Color.alphaBlend(
                foreground.withValues(alpha: 0.12),
                colorScheme.primary,
              )
            : null,
        onPressed: () => unawaited(viewModel.selectSession(meta.id)),
        onHoverChange: (hovered) {
          if (hovered || _hoveredSessionId == meta.id) {
            setState(() => _hoveredSessionId = hovered ? meta.id : null);
          }
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 20),
          child: Row(
            spacing: 6,
            children: [
              Expanded(
                child: Text(
                  meta.title,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: foreground),
                ),
              ),
              if (_hoveredSessionId == meta.id)
                Tooltip(
                  message: '删除会话',
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => unawaited(_confirmDelete(meta)),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        LucideIcons.trash2,
                        size: 14,
                        color: foreground.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepStatus(
    String label, {
    required bool thinking,
    bool runningTool = false,
    bool accordionTitle = false,
    IconData icon = LucideIcons.brain,
  }) {
    final theme = ShadTheme.of(context);
    final colors = accordionTitle
        ? switch (theme.brightness) {
            Brightness.light => const ShadNeutralColorScheme.light(),
            Brightness.dark => const ShadNeutralColorScheme.dark(),
          }
        : theme.colorScheme;
    final text = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.muted.copyWith(
        fontSize: 12,
        color: colors.mutedForeground,
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        if (thinking)
          const FoxyLoadingIndicator(size: 13, strokeWidth: 1.5)
        else
          Icon(icon, size: 13, color: theme.colorScheme.mutedForeground),
        Flexible(
          child: thinking || runningTool
              ? _StepShimmer(colors: colors, child: text)
              : text,
        ),
      ],
    );
  }

  Widget _buildToolStep(AgentChatMessage message) {
    final text = message.text;
    final String label;
    final String details;
    if (text.startsWith(_toolCallPrefix)) {
      final argumentsStart = text.indexOf(' ', _toolCallPrefix.length);
      label = argumentsStart == -1 ? text : text.substring(0, argumentsStart);
      details = argumentsStart == -1
          ? '未记录参数'
          : text.substring(argumentsStart + 1);
    } else if (text.startsWith(_toolFailurePrefix)) {
      label = '工具失败';
      details = text.substring(_toolFailurePrefix.length);
    } else {
      return _buildMessage(message);
    }

    return _AgentStepAccordion(
      key: PageStorageKey(message),
      title: _buildStepStatus(
        label,
        thinking: false,
        accordionTitle: true,
        icon: LucideIcons.wrench,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SelectionArea(
            child: Text(
              details,
              style: ShadTheme.of(context).textTheme.muted
                  .copyWith(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkspace() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Expanded(child: _buildMessageList()),
          _buildComposer(),
        ],
      ),
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

  void _followBottom() {
    _followingBottom.value = true;
    _scrollToBottom();
  }

  bool _isStep(AgentChatMessage message) =>
      message.role == AgentChatRole.reasoning ||
      message.role == AgentChatRole.tool;

  void _scrollToBottom() {
    if (!_followingBottom.value || _scrollScheduled) return;
    _scrollScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollScheduled = false;
      if (!mounted || !_followingBottom.value || !scrollController.hasClients) {
        return;
      }
      final position = scrollController.position;
      if (position.extentAfter <= 1) return;
      position.jumpTo(position.maxScrollExtent);
      // The lazy list can refine its scroll extent after the jump.
      _scrollToBottom();
    });
  }

  void _startNewSession() {
    viewModel.startNewSession();
    _composerFocus.requestFocus();
  }
}

class _AgentStepAccordion extends StatefulWidget {
  final Widget title;
  final List<Widget> children;

  const _AgentStepAccordion({
    required super.key,
    required this.title,
    required this.children,
  });

  @override
  State<_AgentStepAccordion> createState() => _AgentStepAccordionState();
}

class _AgentStepAccordionState extends State<_AgentStepAccordion> {
  late final ShadAccordionController<bool> _controller;

  @override
  Widget build(BuildContext context) {
    return ShadAccordion<bool>(
      controller: _controller,
      children: [
        ShadAccordionItem<bool>(
          value: true,
          title: widget.title,
          padding: const EdgeInsets.symmetric(vertical: 8),
          underlineTitleOnHover: false,
          separator: const SizedBox.shrink(),
          icon: const SizedBox.shrink(),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.children,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final expanded = PageStorage.maybeOf(context)?.readState(context) == true;
    _controller = ShadAccordionController<bool>(expanded ? true : null)
      ..addListener(_saveExpanded);
  }

  void _saveExpanded() {
    PageStorage.maybeOf(context)
        ?.writeState(context, _controller.value.isNotEmpty);
  }
}

class _StepShimmer extends StatefulWidget {
  final ShadColorScheme colors;
  final Widget child;

  const _StepShimmer({required this.colors, required this.child});

  @override
  State<_StepShimmer> createState() => _StepShimmerState();
}

class _StepShimmerState extends State<_StepShimmer>
    with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return widget.child;
    final colors = widget.colors;
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        final offset = _animation.value * 4 - 2;
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment(offset - 1, 0),
            end: Alignment(offset + 1, 0),
            colors: [
              colors.mutedForeground,
              colors.foreground,
              colors.mutedForeground,
            ],
          ).createShader(bounds),
          child: child,
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _animation.stop();
    } else if (!_animation.isAnimating) {
      unawaited(_animation.repeat());
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}
