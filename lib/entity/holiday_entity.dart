import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'holiday_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_holidays')
class HolidayEntity with _HolidayEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Duration0')
  final int duration0;

  @FoxyFullField('Duration1')
  final int duration1;

  @FoxyFullField('Duration2')
  final int duration2;

  @FoxyFullField('Duration3')
  final int duration3;

  @FoxyFullField('Duration4')
  final int duration4;

  @FoxyFullField('Duration5')
  final int duration5;

  @FoxyFullField('Duration6')
  final int duration6;

  @FoxyFullField('Duration7')
  final int duration7;

  @FoxyFullField('Duration8')
  final int duration8;

  @FoxyFullField('Duration9')
  final int duration9;

  @FoxyFullField('Date0')
  final int date0;

  @FoxyFullField('Date1')
  final int date1;

  @FoxyFullField('Date2')
  final int date2;

  @FoxyFullField('Date3')
  final int date3;

  @FoxyFullField('Date4')
  final int date4;

  @FoxyFullField('Date5')
  final int date5;

  @FoxyFullField('Date6')
  final int date6;

  @FoxyFullField('Date7')
  final int date7;

  @FoxyFullField('Date8')
  final int date8;

  @FoxyFullField('Date9')
  final int date9;

  @FoxyFullField('Date10')
  final int date10;

  @FoxyFullField('Date11')
  final int date11;

  @FoxyFullField('Date12')
  final int date12;

  @FoxyFullField('Date13')
  final int date13;

  @FoxyFullField('Date14')
  final int date14;

  @FoxyFullField('Date15')
  final int date15;

  @FoxyFullField('Date16')
  final int date16;

  @FoxyFullField('Date17')
  final int date17;

  @FoxyFullField('Date18')
  final int date18;

  @FoxyFullField('Date19')
  final int date19;

  @FoxyFullField('Date20')
  final int date20;

  @FoxyFullField('Date21')
  final int date21;

  @FoxyFullField('Date22')
  final int date22;

  @FoxyFullField('Date23')
  final int date23;

  @FoxyFullField('Date24')
  final int date24;

  @FoxyFullField('Date25')
  final int date25;

  @FoxyFullField('Region')
  final int region;

  @FoxyFullField('Looping')
  final int looping;

  @FoxyFullField('CalendarFlags0')
  final int calendarFlags0;

  @FoxyFullField('CalendarFlags1')
  final int calendarFlags1;

  @FoxyFullField('CalendarFlags2')
  final int calendarFlags2;

  @FoxyFullField('CalendarFlags3')
  final int calendarFlags3;

  @FoxyFullField('CalendarFlags4')
  final int calendarFlags4;

  @FoxyFullField('CalendarFlags5')
  final int calendarFlags5;

  @FoxyFullField('CalendarFlags6')
  final int calendarFlags6;

  @FoxyFullField('CalendarFlags7')
  final int calendarFlags7;

  @FoxyFullField('CalendarFlags8')
  final int calendarFlags8;

  @FoxyFullField('CalendarFlags9')
  final int calendarFlags9;

  @FoxyBriefField()
  @FoxyFullField('HolidayNameID')
  final int holidayNameId;

  @FoxyFullField('HolidayDescriptionID')
  final int holidayDescriptionId;

  @FoxyBriefField()
  @FoxyFullField('TextureFileName')
  final String textureFileName;

  @FoxyFullField('Priority')
  final int priority;

  @FoxyFullField('CalendarFilterType')
  final int calendarFilterType;

  @FoxyFullField('Flags')
  final int flags;

  const HolidayEntity({
    this.id = 0,
    this.duration0 = 0,
    this.duration1 = 0,
    this.duration2 = 0,
    this.duration3 = 0,
    this.duration4 = 0,
    this.duration5 = 0,
    this.duration6 = 0,
    this.duration7 = 0,
    this.duration8 = 0,
    this.duration9 = 0,
    this.date0 = 0,
    this.date1 = 0,
    this.date2 = 0,
    this.date3 = 0,
    this.date4 = 0,
    this.date5 = 0,
    this.date6 = 0,
    this.date7 = 0,
    this.date8 = 0,
    this.date9 = 0,
    this.date10 = 0,
    this.date11 = 0,
    this.date12 = 0,
    this.date13 = 0,
    this.date14 = 0,
    this.date15 = 0,
    this.date16 = 0,
    this.date17 = 0,
    this.date18 = 0,
    this.date19 = 0,
    this.date20 = 0,
    this.date21 = 0,
    this.date22 = 0,
    this.date23 = 0,
    this.date24 = 0,
    this.date25 = 0,
    this.region = 0,
    this.looping = 0,
    this.calendarFlags0 = 0,
    this.calendarFlags1 = 0,
    this.calendarFlags2 = 0,
    this.calendarFlags3 = 0,
    this.calendarFlags4 = 0,
    this.calendarFlags5 = 0,
    this.calendarFlags6 = 0,
    this.calendarFlags7 = 0,
    this.calendarFlags8 = 0,
    this.calendarFlags9 = 0,
    this.holidayNameId = 0,
    this.holidayDescriptionId = 0,
    this.textureFileName = '',
    this.priority = 0,
    this.calendarFilterType = 0,
    this.flags = 0,
  });

  factory HolidayEntity.fromJson(Map<String, dynamic> json) =>
      _HolidayEntityMixin.fromJson(json);
}
