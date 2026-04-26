import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/header.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var children = [_Header(), _buildContent()];
    return ListView(padding: EdgeInsets.all(16), children: children);
  }

  Widget _buildContent() {
    final children = [
      SizedBox(width: 200, child: _buildMenu()),
      const VerticalDivider(thickness: 1, width: 1),
      const SizedBox(width: 16),
      Expanded(child: AutoRouter()),
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildMenu() {
    var menuItems = [
      _MenuItem(title: '基本设置', icon: LucideIcons.settings),
      _MenuItem(title: '数据库设置', icon: LucideIcons.database),
      _MenuItem(title: '更新日志', icon: LucideIcons.fileText),
    ];
    return Column(
      spacing: 8,
      children: menuItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return _buildMenuItem(item, index);
      }).toList(),
    );
  }

  Widget _buildMenuItem(_MenuItem item, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = _selectedIndex == index;

    return Material(
      color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _handleMenuTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 18,
                color: isSelected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 12),
              Text(
                item.title,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    final route = switch (index) {
      0 => BasicSettingRoute(),
      1 => DatabaseSettingRoute(),
      _ => BasicSettingRoute(),
    };
    AutoRouter.of(context).navigate(route);
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: FoxyHeader('设置'));
  }
}

class _MenuItem {
  final String title;
  final IconData icon;

  const _MenuItem({required this.title, required this.icon});
}
