import 'package:foxy_agent/foxy_agent.dart';

/// AzerothCore inventory relationships are logical links across schemas.
abstract final class CharacterAgentFieldSemantics {
  static Map<String, Map<String, ColumnSemantics>> forDatabase(
    String database,
  ) => {
    '$database.character_inventory': {
      'guid': ColumnSemantics.reference(
        label: '角色',
        reference: ColumnReference(
          table: '$database.characters',
          column: 'guid',
        ),
      ),
      'bag': ColumnSemantics.reference(
        label: '容器物品实例（0 表示角色自带栏位）',
        reference: ColumnReference(
          table: '$database.item_instance',
          column: 'guid',
        ),
      ),
      'item': ColumnSemantics.reference(
        label: '物品实例',
        reference: ColumnReference(
          table: '$database.item_instance',
          column: 'guid',
        ),
      ),
    },
    '$database.item_instance': {
      'itemEntry': const ColumnSemantics.reference(
        label: '物品模板',
        reference: ColumnReference(table: 'item_template', column: 'entry'),
      ),
      'owner_guid': ColumnSemantics.reference(
        label: '物品所有者',
        reference: ColumnReference(
          table: '$database.characters',
          column: 'guid',
        ),
      ),
    },
  };
}
