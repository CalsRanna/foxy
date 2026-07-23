import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/condition_key.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/router_node.dart';

void main() {
  test('RouterNode 只保留实际路由和面包屑状态', () {
    final source = File('lib/router/router_node.dart').readAsStringSync();

    expect(source, isNot(contains('final String? id')));
    expect(source, isNot(contains('String? id')));

    const route = DashboardRoute();
    final node = RouterNode(
      label: '旧标签',
      route: route,
      parentMenu: RouterMenu.condition,
    );
    final renamed = node.copyWith(label: '新标签');

    expect(renamed.label, '新标签');
    expect(identical(renamed.route, route), isTrue);
    expect(renamed.parentMenu, RouterMenu.condition);
  });

  test('更新面包屑标签不会替换详情路由或改变路由参数', () {
    const key = ConditionKey(
      sourceTypeOrReferenceId: 17,
      sourceGroup: 1,
      sourceEntry: 2,
      sourceId: 3,
      elseGroup: 4,
      conditionTypeOrReference: 5,
      conditionTarget: 6,
      conditionValue1: 7,
      conditionValue2: 8,
      conditionValue3: 9,
    );
    final detailRoute = ConditionDetailRoute(conditionKey: key);
    final facade = RouterFacade();

    facade.navigateToDetail(
      label: '旧标签',
      route: detailRoute,
      parentMenu: RouterMenu.condition,
    );
    final routeBeforeRename = facade.path.value.last.route;
    facade.updateCurrentLabel('新标签');

    expect(facade.path.value.last.label, '新标签');
    expect(identical(facade.path.value.last.route, routeBeforeRename), isTrue);
    expect(identical(routeBeforeRename, detailRoute), isTrue);
    expect(detailRoute.args!.conditionKey, key);
  });

  test('详情导航和保存流程不维护第二套字符串身份', () {
    final facade = File('lib/router/router_facade.dart').readAsStringSync();
    final condition = File(
      'lib/page/condition/condition_detail_view_model.dart',
    ).readAsStringSync();
    final gossipMenu = File(
      'lib/page/gossip_menu/gossip_menu_detail_view_model.dart',
    ).readAsStringSync();
    final conditionView = File(
      'lib/page/condition/condition_view.dart',
    ).readAsStringSync();
    final gossipMenuView = File(
      'lib/page/gossip_menu/gossip_menu_view.dart',
    ).readAsStringSync();
    final pageSources = Directory('lib/page')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .map((file) => file.readAsStringSync())
        .join('\n');

    expect(facade, isNot(contains('replaceCurrentDetail')));
    expect(facade, isNot(contains('required String id')));
    expect(pageSources, isNot(contains('replaceCurrentDetail(')));
    expect(
      RegExp(
        r'(?:_?routerFacade)\.navigateToDetail\(\s*id:',
        multiLine: true,
      ).hasMatch(pageSources),
      isFalse,
    );
    expect(condition, contains('final persistedKey = signal<ConditionKey?>'));
    expect(condition, contains('persistedKey.value = newKey'));
    expect(condition, isNot(contains('RouterFacade')));
    expect(gossipMenu, isNot(contains('RouterFacade')));
    expect(conditionView, contains('updateCurrentLabel('));
    expect(gossipMenuView, contains('updateCurrentLabel('));
  });
}
