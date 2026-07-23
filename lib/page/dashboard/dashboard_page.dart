import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/dashboard/component/frequent_module.dart';
import 'package:foxy/page/dashboard/component/introduction.dart';
import 'package:foxy/page/dashboard/component/trend.dart';
import 'package:foxy/page/dashboard/component/version.dart';
import 'package:foxy/page/dashboard/component/welcome.dart';
import 'package:foxy/page/dashboard/dashboard_read_view_model.dart';
import 'package:foxy/page/feature/feature_state_view_model.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/foxy_header.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_flutter.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageRoute();
}

class _DashboardPageRoute extends State<DashboardPage> {
  final viewModel = GetIt.instance.get<DashboardReadViewModel>();
  final featureState = GetIt.instance.get<FeatureStateViewModel>();
  final routerFacade = GetIt.instance.get<RouterFacade>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _Header(),
        Watch(
          (context) => Welcome(
            activityLogCount: viewModel.activityCount.value,
            featureCount: viewModel.featureCount.value,
          ),
        ),
        SizedBox(height: 16),
        _buildWorkspace(),
      ],
    );
  }

  Widget _buildWorkspace() {
    final leftChildren = [
      Watch(
        (_) => FrequentModuleComponent(
          features: featureState.favoriteFeatures.value,
          onMenuTap: _navigateToMenu,
        ),
      ),
      SizedBox(height: 16),
      Watch((_) => Trend(activities: viewModel.recentActivities.value)),
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

  void _navigateToMenu(RouterMenu menu) {
    final feature = featureState.allFeatures.value
        .where((feature) => feature.routerMenu == menu.name)
        .firstOrNull;
    routerFacade.navigateToMenu(
      menu,
      parentMenu: feature?.isPinned ?? true ? null : RouterMenu.more,
    );
  }

  Future<void> _initialize() async {
    try {
      await viewModel.initSignals();
    } catch (error) {
      if (!mounted) return;
      DialogUtil.instance.error('加载仪表板数据失败：$error');
    }
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
