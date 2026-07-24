import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/player_create_info_entity.dart';

void main() {
  test('PlayerCreateInfoKey 和 Brief 覆盖 race + class', () {
    const entity = PlayerCreateInfoEntity(race: 1, class_: 2);
    const key = PlayerCreateInfoKey(race: 1, class_: 2);
    expect(PlayerCreateInfoKey.fromEntity(entity), key);
    expect(const BriefPlayerCreateInfoEntity(race: 1, class_: 2).key, key);
    expect(key, isNot(const PlayerCreateInfoKey(race: 1, class_: 3)));
  });

  test('Repository 使用完整旧 key、完整 candidate 和写入结果', () {
    final source = File(
      'lib/repository/player_create_info_repository.dart',
    ).readAsStringSync();
    expect(source, contains('PlayerCreateInfoKey originalKey'));
    expect(source, contains('.update(info.toJson())'));
    expect(source, contains("where('race', key.race)"));
    expect(source, contains("where('class', key.class_)"));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('savePlayerCreateInfo(')));
  });

  test('详情使用 persistedKey、单一 ViewModel 和实时父键子 Tab', () {
    final viewModel = File(
      'lib/page/player_create_info/player_create_info_detail_view_model.dart',
    ).readAsStringSync();
    final page = File(
      'lib/page/player_create_info/player_create_info_detail_page.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/player_create_info/player_create_info_view.dart',
    ).readAsStringSync();
    final listViewModel = File(
      'lib/page/player_create_info/player_create_info_list_view_model.dart',
    ).readAsStringSync();
    expect(viewModel, contains('persistedKey = signal<PlayerCreateInfoKey?>'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(viewModel, contains('persistedKey.value = PlayerCreateInfoKey'));
    expect(page, contains('PlayerCreateInfoView(viewModel: viewModel)'));
    expect(page, contains('final key = viewModel.persistedKey.value'));
    expect(page, contains('disabledIndexes: key == null'));
    expect(view, contains('required this.viewModel'));
    expect(view, contains('GetIt.instance.get<RouterFacade>()'));
    expect(view, isNot(contains('enabled: !pkReadOnly')));
    final listPage = File(
      'lib/page/player_create_info/player_create_info_list_page.dart',
    ).readAsStringSync();
    expect(listViewModel, isNot(contains('RouterFacade')));
    expect(listPage, contains('playerCreateInfoKey: info?.key'));
  });
}
