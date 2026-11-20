import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AgentComposer extends StatefulWidget {
  final TextEditingController controller;
  final bool running;
  final bool configured;
  final bool hasSession;
  final VoidCallback onSend;
  final VoidCallback onStop;
  final VoidCallback onConfigure;

  const AgentComposer({
    super.key,
    required this.controller,
    required this.running,
    required this.configured,
    required this.hasSession,
    required this.onSend,
    required this.onStop,
    required this.onConfigure,
  });

  @override
  State<AgentComposer> createState() => _AgentComposerState();
}

class _AgentComposerState extends State<AgentComposer> {
  final _focusNode = FocusNode();

  bool get _canSend =>
      widget.configured &&
      widget.hasSession &&
      !widget.running &&
      widget.controller.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    final input = Focus(
      canRequestFocus: false,
      onKeyEvent: (_, event) => _handleKey(event),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        readOnly: widget.running,
        minLines: 1,
        maxLines: 6,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        style: TextStyle(fontSize: 13, color: colors.foreground),
        decoration: InputDecoration.collapsed(
          hintText: '输入问题，让 AI 查询 world 库和 foxy 库',
          hintStyle: theme.textTheme.muted.copyWith(fontSize: 13),
        ),
      ),
    );

    return ListenableBuilder(
      listenable: Listenable.merge([_focusNode, widget.controller]),
      child: input,
      builder: (context, child) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
        decoration: BoxDecoration(
          color: colors.background,
          border: Border.all(
            color: _focusNode.hasFocus ? colors.primary : colors.border,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 8,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: child!,
              ),
            ),
            if (widget.configured || widget.running)
              IconButton.filled(
                tooltip: widget.running ? '停止' : '发送（Enter）',
                icon: Icon(
                  widget.running ? LucideIcons.square : LucideIcons.arrowUp,
                  size: 16,
                  color: widget.running || _canSend
                      ? Theme.of(context).colorScheme.onPrimary
                      : null,
                ),
                onPressed: widget.running
                    ? widget.onStop
                    : (_canSend ? widget.onSend : null),
                style: IconButton.styleFrom(
                  minimumSize: const Size.square(34),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )
            else
              ShadButton.outline(
                size: ShadButtonSize.sm,
                onPressed: widget.onConfigure,
                child: const Text('前往设置'),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKey(KeyEvent event) {
    final key = event.logicalKey;
    final keyboard = HardwareKeyboard.instance;
    if (widget.running ||
        event is! KeyDownEvent ||
        (key != LogicalKeyboardKey.enter &&
            key != LogicalKeyboardKey.numpadEnter) ||
        keyboard.isControlPressed ||
        keyboard.isAltPressed ||
        keyboard.isMetaPressed) {
      return KeyEventResult.ignored;
    }

    final value = widget.controller.value;
    if (value.isComposingRangeValid && !value.composing.isCollapsed) {
      return KeyEventResult.ignored;
    }
    if (keyboard.isShiftPressed) {
      final start = value.selection.isValid
          ? value.selection.start
          : value.text.length;
      final end = value.selection.isValid ? value.selection.end : start;
      widget.controller.value = TextEditingValue(
        text: value.text.replaceRange(start, end, '\n'),
        selection: TextSelection.collapsed(offset: start + 1),
      );
    } else if (_canSend) {
      widget.onSend();
    }
    return KeyEventResult.handled;
  }
}
