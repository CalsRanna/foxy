import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'game_object_template_entity.g.dart';

@FoxyBriefEntity()
@FoxyBriefField.text('localeName')
@FoxyFilterEntity()
@FoxyFullEntity(table: 'gameobject_template')
class GameObjectTemplateEntity with _GameObjectTemplateEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('type')
  final int type;

  @FoxyFullField('displayId')
  final int displayId;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('name')
  final String name;

  @FoxyFullField('IconName')
  final String iconName;

  @FoxyFullField('castBarCaption')
  final String castBarCaption;

  @FoxyFullField('unk1')
  final String unk1;

  @FoxyBriefField()
  @FoxyFullField('size')
  final double size;

  @FoxyFullField('Data0')
  final int data0;

  @FoxyFullField('Data1')
  final int data1;

  @FoxyFullField('Data2')
  final int data2;

  @FoxyFullField('Data3')
  final int data3;

  @FoxyFullField('Data4')
  final int data4;

  @FoxyFullField('Data5')
  final int data5;

  @FoxyFullField('Data6')
  final int data6;

  @FoxyFullField('Data7')
  final int data7;

  @FoxyFullField('Data8')
  final int data8;

  @FoxyFullField('Data9')
  final int data9;

  @FoxyFullField('Data10')
  final int data10;

  @FoxyFullField('Data11')
  final int data11;

  @FoxyFullField('Data12')
  final int data12;

  @FoxyFullField('Data13')
  final int data13;

  @FoxyFullField('Data14')
  final int data14;

  @FoxyFullField('Data15')
  final int data15;

  @FoxyFullField('Data16')
  final int data16;

  @FoxyFullField('Data17')
  final int data17;

  @FoxyFullField('Data18')
  final int data18;

  @FoxyFullField('Data19')
  final int data19;

  @FoxyFullField('Data20')
  final int data20;

  @FoxyFullField('Data21')
  final int data21;

  @FoxyFullField('Data22')
  final int data22;

  @FoxyFullField('Data23')
  final int data23;

  @FoxyFullField('AIName')
  final String aiName;

  @FoxyFullField('ScriptName')
  final String scriptName;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const GameObjectTemplateEntity({
    this.entry = 0,
    this.type = 0,
    this.displayId = 0,
    this.name = '',
    this.iconName = '',
    this.castBarCaption = '',
    this.unk1 = '',
    this.size = 1.0,
    this.data0 = 0,
    this.data1 = 0,
    this.data2 = 0,
    this.data3 = 0,
    this.data4 = 0,
    this.data5 = 0,
    this.data6 = 0,
    this.data7 = 0,
    this.data8 = 0,
    this.data9 = 0,
    this.data10 = 0,
    this.data11 = 0,
    this.data12 = 0,
    this.data13 = 0,
    this.data14 = 0,
    this.data15 = 0,
    this.data16 = 0,
    this.data17 = 0,
    this.data18 = 0,
    this.data19 = 0,
    this.data20 = 0,
    this.data21 = 0,
    this.data22 = 0,
    this.data23 = 0,
    this.aiName = '',
    this.scriptName = '',
    this.verifiedBuild = 0,
  });

  factory GameObjectTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _GameObjectTemplateEntityMixin.fromJson(json);
}

extension BriefGameObjectTemplateEntityDisplay
    on BriefGameObjectTemplateEntity {
  String get displayName => localeName.isNotEmpty ? localeName : name;
}
