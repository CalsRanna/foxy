import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_filter_entity.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final gossipMenuPickerDelegate = EntityPickerDelegate<BriefGossipMenuEntity>(
  title: '对话菜单',
  errorLabel: '搜索对话菜单失败',
  filters: const [EntityPickerFilter('菜单ID'), EntityPickerFilter('文本内容')],
  columns: [
    EntityPickerColumn(header: '菜单ID', width: 120, text: (BriefGossipMenuEntity t) => t.menuId.toString()),
    EntityPickerColumn(header: '文本ID', width: 120, text: (BriefGossipMenuEntity t) => t.textId.toString()),
    EntityPickerColumn(header: '文本内容', text: (BriefGossipMenuEntity t) => t.text),
  ],
  idOf: (BriefGossipMenuEntity t) => t.menuId,
  fetch: (page, v) => GetIt.instance.get<GossipMenuRepository>().getBriefGossipMenus(
      filter: GossipMenuFilterEntity(menuId: v[0], text: v[1]), page: page),
  count: (v) => GetIt.instance.get<GossipMenuRepository>()
      .countGossipMenus(filter: GossipMenuFilterEntity(menuId: v[0], text: v[1])),
);
