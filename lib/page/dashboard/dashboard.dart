import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foxy/page/dashboard/component/welcome.dart';
import 'package:foxy/page/dashboard/component/workspace.dart';
import 'package:foxy/provider/application.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/widget/breadcrumb.dart';
import 'package:foxy/widget/header.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const children = [
      _Breadcrumb(),
      _Header(),
      Welcome(),
      SizedBox(height: 16),
      Workspace(),
    ];
    return ListView(padding: const EdgeInsets.all(16), children: children);
  }
}

class _Breadcrumb extends ConsumerWidget {
  const _Breadcrumb();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashboard = BreadcrumbItem(
      onTap: () => navigateDashboard(context, ref),
      child: Text('首页'),
    );
    final children = [
      dashboard,
      BreadcrumbItem(child: Text('工作台')),
    ];
    return Breadcrumb(children: children);
  }

  void navigateDashboard(BuildContext context, WidgetRef ref) {
    final provider = selectedMenuIndexNotifierProvider;
    final notifier = ref.read(provider.notifier);
    notifier.select(0);
    AutoRouter.of(context).navigate(DashboardRoute());
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.symmetric(vertical: 12);
    return Padding(padding: edgeInsets, child: Header('工作台'));
  }
}
