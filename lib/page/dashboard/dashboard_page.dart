import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/dashboard/component/frequent_module.dart';
import 'package:foxy/page/dashboard/component/introduction.dart';
import 'package:foxy/page/dashboard/component/trend.dart';
import 'package:foxy/page/dashboard/component/version.dart';
import 'package:foxy/page/dashboard/component/welcome.dart';
import 'package:foxy/page/dashboard/dashboard_view_model.dart';
import 'package:foxy/widget/header.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageRoute();
}

class _DashboardPageRoute extends State<DashboardPage> {
  final viewModel = GetIt.instance.get<DashboardViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.initSignals();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [_Header(), Welcome(), SizedBox(height: 16), _buildWorkspace()],
    );
  }

  Widget _buildWorkspace() {
    final leftChildren = [
      FrequentModuleComponent(onMenuTap: viewModel.navigateToMenu),
      SizedBox(height: 16),
      Trend(),
    ];
    final leftColumn = Column(children: leftChildren);
    final rightChildren = [
      Introduction(),
      SizedBox(height: 16),
      Watch(
        (_) => Version(
          coreVersion: viewModel.coreVersion.value,
          revision: viewModel.coreRevision.value,
          databaseVersion: viewModel.databaseVersion.value,
          softwareVersion: viewModel.softwareVersion.value,
        ),
      ),
    ];
    final rightColumn = Column(children: rightChildren);
    final children = [
      Expanded(flex: 3, child: leftColumn),
      SizedBox(width: 16),
      Expanded(flex: 1, child: rightColumn),
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.only(bottom: 12);
    return Padding(padding: edgeInsets, child: FoxyHeader('工作台'));
  }
}
