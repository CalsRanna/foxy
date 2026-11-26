import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';

void main() {
  test('Empty slots use -1 and stat type zero is displayed', () {
    const entity = ScalingStatDistributionEntity(
      id: 1,
      statId0: 0,
      bonus0: 10000,
    );
    expect(entity.displayStats, '法力值(10000)');
    expect(const ScalingStatDistributionEntity().statId9, -1);
    expect(const ScalingStatDistributionEntity().maxlevel, 80);
  });

  test('Stat distribution shows stat names and filters invalid slots', () {
    const entity = ScalingStatDistributionEntity(
      id: 1,
      statId0: 0,
      bonus0: 0, // Legacy placeholder with a zero stat ID and bonus.
      statId1: 3,
      bonus1: 300,
      statId3: 1,
      bonus3: 300,
    );
    expect(entity.displayStats, '敏捷(300), 生命值(300)');
  });

  test('An entirely empty distribution displays a dash', () {
    const entity = ScalingStatDistributionEntity(id: 1);
    expect(entity.displayStats, '-');
  });

  test('Unknown stats fall back to their numeric values', () {
    const entity = ScalingStatDistributionEntity(
      id: 1,
      statId1: 2, // Legacy Mana ID missing from the current lookup table.
      bonus1: 300,
    );
    expect(entity.displayStats, '2(300)');
  });

  test('statEntries returns only valid slots', () {
    const entity = ScalingStatDistributionEntity(
      id: 1,
      statId0: -1, // Empty slot.
      statId1: 0,
      bonus1: 0, // Zero ID and bonus placeholder.
      statId2: 3,
      bonus2: 300,
    );
    expect(
      ScalingStatDistributionEntity.statEntries(
        [entity.statId0, entity.statId1, entity.statId2],
        [entity.bonus0, entity.bonus1, entity.bonus2],
      ),
      [(3, 300)],
    );
  });

  test(
    'The DBC definition matches the 22-column AzerothCore 3.3.5a format',
    () {
      final definition =
          DbcDefinitions.byTable['dbc_scaling_stat_distribution']!;
      expect(definition.fileName, 'ScalingStatDistribution.dbc');
      expect(definition.schema.format, 'niiiiiiiiiiiiiiiiiiiii');
      expect(definition.schema.fields, hasLength(22));
    },
  );
}
