import 'package:foxy_agent/foxy_agent.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

/// Adapts the condition editor's shared parameter specs to the agent catalog.
abstract final class ConditionAgentFieldSemantics {
  static const _references = {
    ConditionValueReference.achievement: ColumnReference(
      table: 'foxy.dbc_achievement',
      column: 'ID',
    ),
    ConditionValueReference.area: ColumnReference(
      table: 'foxy.dbc_area_table',
      column: 'ID',
    ),
    ConditionValueReference.creature: ColumnReference(
      table: 'creature_template',
      column: 'entry',
    ),
    ConditionValueReference.faction: ColumnReference(
      table: 'foxy.dbc_faction',
      column: 'ID',
    ),
    ConditionValueReference.gameObject: ColumnReference(
      table: 'gameobject_template',
      column: 'entry',
    ),
    ConditionValueReference.item: ColumnReference(
      table: 'item_template',
      column: 'entry',
    ),
    ConditionValueReference.map: ColumnReference(
      table: 'foxy.dbc_map',
      column: 'ID',
    ),
    ConditionValueReference.quest: ColumnReference(
      table: 'quest_template',
      column: 'ID',
    ),
    ConditionValueReference.skill: ColumnReference(
      table: 'foxy.dbc_skill_line',
      column: 'ID',
    ),
    ConditionValueReference.spell: ColumnReference(
      table: 'foxy.dbc_spell',
      column: 'ID',
    ),
    ConditionValueReference.title: ColumnReference(
      table: 'foxy.dbc_char_titles',
      column: 'ID',
    ),
  };

  static List<ColumnSemanticBranch> value1(List<String> dependsOn) =>
      _branches(dependsOn.single, (config) => config.value1);

  static List<ColumnSemanticBranch> value2(List<String> dependsOn) => _branches(
    dependsOn.first,
    (config) => config.value2,
    value1Column: dependsOn[1],
  );

  static List<ColumnSemanticBranch> value3(List<String> dependsOn) =>
      _branches(dependsOn.single, (config) => config.value3);

  static List<ColumnSemanticBranch> _branches(
    String typeColumn,
    IntegerFieldSpec<ConditionValueReference> Function(ConditionValueConfig)
    specFor, {
    String? value1Column,
  }) => [
    ...ConditionValueConfig.parameterContexts(
      forValue2: value1Column != null,
    ).map((context) {
      final (:type, :value1) = context;
      final config = ConditionValueConfig.forType(type, value1: value1 ?? 0);
      return ColumnSemanticBranch(
        label: ConditionType.conditionTypeLabels[type]!,
        when: [
          ColumnSemanticCondition.equals(typeColumn, type),
          if (value1 != null)
            ColumnSemanticCondition.equals(value1Column!, value1),
        ],
        semantics: _meaning(
          specFor(config),
          specialValues: type == 31 && value1Column != null
              ? const {0: '不限制对象条目，无需联表'}
              : const {},
        ),
      );
    }),
    ColumnSemanticBranch(
      label: '引用条件模板',
      when: [ColumnSemanticCondition.lessThan(typeColumn, 0)],
      semantics: _meaning(specFor(ConditionValueConfig.forType(-1))),
    ),
  ];

  static ColumnSemantics _meaning(
    IntegerFieldSpec<ConditionValueReference> spec, {
    Map<int, String> specialValues = const {},
  }) => switch (spec) {
    IntegerEnumFieldSpec(:final label, :final options) =>
      ColumnSemantics.enumValues(label: label, values: options),
    IntegerFlagsFieldSpec(:final label, :final flags) => ColumnSemantics.flags(
      label: label,
      flags: flags
          .map((flag) => ColumnFlag(value: flag.value, label: flag.label))
          .toList(),
    ),
    IntegerReferenceFieldSpec(:final label, :final reference) =>
      ColumnSemantics.reference(
        label: label,
        reference: _references[reference]!,
        specialValues: specialValues,
      ),
    IntegerNumberFieldSpec(:final label)
        when ConditionValueConfig.isUnused(spec) =>
      ColumnSemantics.unused(label: label),
    IntegerNumberFieldSpec(:final label) => ColumnSemantics.number(
      label: label,
      specialValues: specialValues,
    ),
  };
}
