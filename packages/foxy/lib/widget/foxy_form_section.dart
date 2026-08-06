import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Uniform form-section area: title + card container
///
/// Section titles and card spacing stay consistent across all modules:
/// 8px between title and card, 8px between field rows.
class FoxyFormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const FoxyFormSection({
    super.key,
    required this.title,
    required this.children,
  });

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
