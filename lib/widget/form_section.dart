import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 统一的表单分组区域：标题 + 卡片容器
///
/// 所有模块的 section 标题和卡片间距保持一致：
/// 标题距卡片 8px，每行字段间距 8px。
class FormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const FormSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(title),
        ),
        const SizedBox(height: 8),
        ShadCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: children,
          ),
        ),
      ],
    );
  }
}
