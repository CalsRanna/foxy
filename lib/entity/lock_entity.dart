import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'lock_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_lock')
class LockEntity with _LockEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('Type0')
  final int type0;

  @FoxyFullField('Type1')
  final int type1;

  @FoxyFullField('Type2')
  final int type2;

  @FoxyFullField('Type3')
  final int type3;

  @FoxyFullField('Type4')
  final int type4;

  @FoxyFullField('Type5')
  final int type5;

  @FoxyFullField('Type6')
  final int type6;

  @FoxyFullField('Type7')
  final int type7;

  @FoxyBriefField()
  @FoxyFullField('Index0')
  final int index0;

  @FoxyFullField('Index1')
  final int index1;

  @FoxyFullField('Index2')
  final int index2;

  @FoxyFullField('Index3')
  final int index3;

  @FoxyFullField('Index4')
  final int index4;

  @FoxyFullField('Index5')
  final int index5;

  @FoxyFullField('Index6')
  final int index6;

  @FoxyFullField('Index7')
  final int index7;

  @FoxyBriefField()
  @FoxyFullField('Skill0')
  final int skill0;

  @FoxyFullField('Skill1')
  final int skill1;

  @FoxyFullField('Skill2')
  final int skill2;

  @FoxyFullField('Skill3')
  final int skill3;

  @FoxyFullField('Skill4')
  final int skill4;

  @FoxyFullField('Skill5')
  final int skill5;

  @FoxyFullField('Skill6')
  final int skill6;

  @FoxyFullField('Skill7')
  final int skill7;

  @FoxyFullField('Action0')
  final int action0;

  @FoxyFullField('Action1')
  final int action1;

  @FoxyFullField('Action2')
  final int action2;

  @FoxyFullField('Action3')
  final int action3;

  @FoxyFullField('Action4')
  final int action4;

  @FoxyFullField('Action5')
  final int action5;

  @FoxyFullField('Action6')
  final int action6;

  @FoxyFullField('Action7')
  final int action7;

  const LockEntity({
    this.id = 0,
    this.type0 = 0,
    this.type1 = 0,
    this.type2 = 0,
    this.type3 = 0,
    this.type4 = 0,
    this.type5 = 0,
    this.type6 = 0,
    this.type7 = 0,
    this.index0 = 0,
    this.index1 = 0,
    this.index2 = 0,
    this.index3 = 0,
    this.index4 = 0,
    this.index5 = 0,
    this.index6 = 0,
    this.index7 = 0,
    this.skill0 = 0,
    this.skill1 = 0,
    this.skill2 = 0,
    this.skill3 = 0,
    this.skill4 = 0,
    this.skill5 = 0,
    this.skill6 = 0,
    this.skill7 = 0,
    this.action0 = 0,
    this.action1 = 0,
    this.action2 = 0,
    this.action3 = 0,
    this.action4 = 0,
    this.action5 = 0,
    this.action6 = 0,
    this.action7 = 0,
  });

  factory LockEntity.fromJson(Map<String, dynamic> json) =>
      _LockEntityMixin.fromJson(json);
}
