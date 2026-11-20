import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:gpt_markdown/custom_widgets/code_field.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AgentMarkdown extends StatelessWidget {
  final String text;
  final bool muted;

  const AgentMarkdown(this.text, {super.key, this.muted = false});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    final foreground = muted ? colors.mutedForeground : colors.foreground;
    final body = theme.textTheme.p.copyWith(
      fontSize: 13,
      height: 1.6,
      color: foreground,
    );
    final heading = body.copyWith(
      height: 1.35,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
    );

    return GptMarkdownTheme(
      gptThemeData: GptMarkdownThemeData(
        brightness: theme.brightness,
        h1: heading.copyWith(fontSize: 22),
        h2: heading.copyWith(fontSize: 18),
        h3: heading.copyWith(fontSize: 16),
        h4: heading.copyWith(fontSize: 14),
        h5: heading,
        h6: heading,
        autoAddDividerLineAfterH1: false,
        hrLineColor: colors.border,
        hrLinePadding: const EdgeInsets.symmetric(vertical: 4),
        linkColor: colors.primary,
        linkHoverColor: colors.primary.withValues(alpha: 0.8),
        styleSheet: GptMarkdownStyleSheet(
          blockSpacing: 8,
          heading: const HeadingStyle(
            padding: EdgeInsets.symmetric(vertical: 2),
          ),
          link: const LinkStyle(decoration: TextDecoration.underline),
          inlineCode: InlineCodeStyle(
            color: foreground,
            backgroundColor: colors.muted,
            borderWidth: 0,
            borderRadius: const Radius.circular(4),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          ),
          table: TableStyle(
            overflow: TableOverflow.wrap,
            columnWidth: const FlexColumnWidth(),
            borderColor: colors.border,
            borderRadius: theme.radius.topLeft,
            cellPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            headerBackground: colors.muted,
            headerTextStyle: body.copyWith(fontWeight: FontWeight.w600),
          ),
          blockQuote: BlockQuoteStyle(
            barWidth: 2,
            barColor: colors.border,
            padding: const EdgeInsetsDirectional.only(start: 12),
            margin: EdgeInsets.zero,
            textStyle: body.copyWith(color: colors.mutedForeground),
          ),
          list: ListStyle(
            bulletColor: foreground,
            markerTextStyle: body,
            indent: 4,
            gapAfterMarker: 8,
          ),
        ),
      ),
      child: SelectionArea(
        child: GptMarkdown(
          text,
          style: body,
          codeBuilder: (_, language, code, _) => _AgentCodeBlock(
            language: language,
            code: code,
            color: foreground,
          ),
        ),
      ),
    );
  }
}

class _AgentCodeBlock extends StatefulWidget {
  final String language;
  final String code;
  final Color color;

  const _AgentCodeBlock({
    required this.language,
    required this.code,
    required this.color,
  });

  @override
  State<_AgentCodeBlock> createState() => _AgentCodeBlockState();
}

class _AgentCodeBlockState extends State<_AgentCodeBlock> {
  String? _copiedCode;
  Timer? _copyFeedback;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    final copied = _copiedCode == widget.code;
    final copyLabel = copied ? '已复制' : '复制代码';
    final language = widget.language.trim();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.muted,
        borderRadius: theme.radius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 4, 0),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Text(
                    language.isEmpty ? '代码' : language,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.muted.copyWith(fontSize: 11),
                  ),
                ),
                ShadButton.ghost(
                  width: 28,
                  height: 28,
                  padding: EdgeInsets.zero,
                  foregroundColor: colors.mutedForeground,
                  onPressed: _copyCode,
                  child: Icon(
                    copied ? LucideIcons.check : LucideIcons.copy,
                    size: 14,
                    semanticLabel: copyLabel,
                  ),
                ),
              ],
            ),
          ),
          CodeField(
            name: language,
            codes: widget.code,
            scalesItsOwnText: true,
            style: CodeBlockStyle(
              backgroundColor: Colors.transparent,
              borderRadius: Radius.zero,
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              fontSize: 12,
              textColor: widget.color,
              showLanguageLabel: false,
              showCopyButton: false,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _copyFeedback?.cancel();
    super.dispose();
  }

  Future<void> _copyCode() async {
    final code = widget.code;
    try {
      await Clipboard.setData(ClipboardData(text: code));
    } on PlatformException {
      if (mounted) DialogUtil.instance.error('复制代码失败');
      return;
    }
    if (!mounted) return;
    _copyFeedback?.cancel();
    setState(() => _copiedCode = code);
    _copyFeedback = Timer(const Duration(seconds: 2), () {
      setState(() => _copiedCode = null);
    });
  }
}
