import 'package:flutter/material.dart';

/// 表单行：左侧标签 + 右侧输入组件。
///
/// 只负责布局，不创建输入框、不持有 Controller。
class FoxyFormItem extends StatelessWidget {
  final String? label;
  final Widget child;

  const FoxyFormItem({super.key, this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        _buildLeading(),
        Expanded(child: child),
      ],
    );
  }

  Widget _buildLeading() {
    if (label == null) return const SizedBox();
    if (label!.isEmpty) return const SizedBox();
    return SizedBox(width: 96, child: Text(label!, textAlign: TextAlign.end));
  }
}
