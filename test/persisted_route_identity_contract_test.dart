import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/condition_entity.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/router_node.dart';

void main() {
  test('RouterNode 只保留实际路由和面包屑状态', () {
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

  test('详情面包屑文案统一为“XXX详情”且保留详情路由与参数', () {
    const key = ConditionKey(
      sourceTypeOrReferenceId: 17, sourceGroup: 1, sourceEntry: 2, sourceId: 3,
      elseGroup: 4, conditionTypeOrReference: 5, conditionTarget: 6,
      conditionValue1: 7, conditionValue2: 8, conditionValue3: 9,
    );
    final detailRoute = ConditionDetailRoute(conditionKey: key);
    final facade = RouterFacade();

    facade.navigateToDetail(route: detailRoute, parentMenu: RouterMenu.condition);
    final lastNode = facade.path.value.last;

    expect(lastNode.label, '条件详情');
    expect(identical(lastNode.route, detailRoute), isTrue);
    expect(detailRoute.args!.conditionKey, key);
  });
}
