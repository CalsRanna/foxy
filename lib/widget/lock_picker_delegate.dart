import 'package:foxy/entity/lock_entity.dart';
import 'package:foxy/repository/lock_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:get_it/get_it.dart';

final lockPickerDelegate = EntityPickerDelegate<LockEntity>(
  title: '锁',
  errorLabel: '搜索锁失败',
  filters: const [EntityPickerFilter('锁ID')],
  columns: [
    EntityPickerColumn(header: '编号', width: 120, text: (LockEntity t) => t.id.toString()),
    EntityPickerColumn(header: '类型', width: 120, text: (LockEntity t) => t.type0.toString()),
    EntityPickerColumn(header: '索引', width: 120, text: (LockEntity t) => t.index0.toString()),
    EntityPickerColumn(header: '技能', text: (LockEntity t) => t.skill0.toString()),
  ],
  idOf: (LockEntity t) => t.id,
  fetch: (page, v) => GetIt.instance.get<LockRepository>()
      .getLocks(id: v[0].isEmpty ? null : v[0], page: page),
  count: (v) => GetIt.instance.get<LockRepository>().countLocks(id: v[0].isEmpty ? null : v[0]),
);
