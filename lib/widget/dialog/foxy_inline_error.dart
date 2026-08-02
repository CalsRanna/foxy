import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 对话框内联错误提示，替代 [DialogUtil.error] 在对话框内的使用。
///
/// 对话框内操作（保存、查询等）失败时用内联错误展示，
/// 保留对话框状态（输入、筛选、分页），不关闭自身。
/// [message] 为 null 时渲染空占位，调用方无需判空。
class FoxyInlineError extends StatelessWidget {
  final String? message;

  const FoxyInlineError({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    final theme = ShadTheme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.destructive.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: theme.colorScheme.destructive.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        message!,
        style: theme.textTheme.small.copyWith(
          color: theme.colorScheme.destructive,
        ),
      ),
    );
  }
}
