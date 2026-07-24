const fs = require('fs');
const path = require('path');

const repositoryDir = path.join(process.cwd(), 'lib/repository');
const unannotatedRepositories = [
  'creature_default_trainer_repository.dart',
  'creature_equip_template_repository.dart',
  'creature_on_kill_reputation_repository.dart',
  'creature_quest_ender_repository.dart',
  'creature_quest_item_repository.dart',
  'creature_quest_starter_repository.dart',
  'creature_template_addon_repository.dart',
  'creature_template_locale_repository.dart',
  'creature_template_resistance_repository.dart',
  'creature_template_spell_repository.dart',
  'game_object_quest_ender_repository.dart',
  'game_object_quest_item_repository.dart',
  'game_object_quest_starter_repository.dart',
  'game_object_template_addon_repository.dart',
  'game_object_template_locale_repository.dart',
  'gossip_menu_option_locale_repository.dart',
  'gossip_menu_option_repository.dart',
  'item_template_locale_repository.dart',
  'npc_text_locale_repository.dart',
  'npc_trainer_repository.dart',
  'npc_vendor_repository.dart',
  'page_text_locale_repository.dart',
  'player_create_info_action_repository.dart',
  'player_create_info_cast_spell_repository.dart',
  'player_create_info_item_repository.dart',
  'player_create_info_skill_repository.dart',
  'player_create_info_spell_custom_repository.dart',
  'quest_offer_reward_locale_repository.dart',
  'quest_offer_reward_repository.dart',
  'quest_request_items_locale_repository.dart',
  'quest_request_items_repository.dart',
  'quest_template_addon_repository.dart',
  'quest_template_locale_repository.dart',
  'spell_area_repository.dart',
  'spell_bonus_data_repository.dart',
  'spell_custom_attr_repository.dart',
  'spell_group_repository.dart',
  'spell_linked_spell_repository.dart',
  'spell_loot_template_repository.dart',
  'spell_rank_repository.dart',
];

const aliases = {
  AchievementCriteria: [
    'getAchievementCriterion',
    'storeAchievementCriterion',
    'updateAchievementCriterion',
    'destroyAchievementCriterion',
  ],
  ItemRandomProperties: [
    'getItemRandomProperty',
    'storeItemRandomProperty',
    'updateItemRandomProperty',
    'destroyItemRandomProperty',
  ],
  ItemVisuals: [
    'getItemVisual',
    'storeItemVisual',
    'updateItemVisual',
    'destroyItemVisual',
  ],
  SoundProviderPreferences: [
    'getSoundProviderPreference',
    'storeSoundProviderPreference',
    'updateSoundProviderPreference',
    'destroySoundProviderPreference',
  ],
};

const lootBases = [
  'CreatureLootTemplate',
  'DisenchantLootTemplate',
  'GameObjectLootTemplate',
  'ItemLootTemplate',
  'MillingLootTemplate',
  'PickpocketingLootTemplate',
  'ProspectingLootTemplate',
  'ReferenceLootTemplate',
  'SkinningLootTemplate',
];
for (const base of lootBases) {
  aliases[base] = [
    'getLootTemplate',
    'storeLootTemplate',
    'updateLootTemplate',
    'destroyLootTemplate',
  ];
}

function removeBlockMethod(source, methodName) {
  const escaped = methodName.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const pattern = new RegExp(
    `\\n  (?:Future(?:<[^\\n]*>)?|QueryBuilder|void|Map<[^\\n]*>)[^\\n]*\\b${escaped}\\s*\\(`,
  );
  let match;
  while ((match = pattern.exec(source)) !== null) {
    const start = match.index;
    const openingBrace = source.indexOf('{', match.index);
    const arrow = source.indexOf('=>', match.index);
    if (arrow !== -1 && (openingBrace === -1 || arrow < openingBrace)) {
      const semicolon = source.indexOf(';', arrow);
      source = source.slice(0, start) + '\n' + source.slice(semicolon + 1);
      continue;
    }
    if (openingBrace === -1) {
      throw new Error(`Cannot find body for ${methodName}`);
    }
    let depth = 0;
    let end = openingBrace;
    for (; end < source.length; end++) {
      if (source[end] === '{') depth++;
      if (source[end] === '}') {
        depth--;
        if (depth === 0) {
          end++;
          break;
        }
      }
    }
    while (source[end] === '\n') end++;
    source = source.slice(0, start) + '\n\n' + source.slice(end);
  }
  return source;
}

const files = fs
  .readdirSync(repositoryDir)
  .filter((name) => name.endsWith('_repository.dart'));
const targets = new Set(unannotatedRepositories);
for (const name of files) {
  const source = fs.readFileSync(path.join(repositoryDir, name), 'utf8');
  if (source.includes('@FoxyRepository(')) targets.add(name);
}

for (const name of targets) {
  const filePath = path.join(repositoryDir, name);
  let source = fs.readFileSync(filePath, 'utf8');
  const classMatch = source.match(/class\s+(\w+Repository)\b/);
  if (!classMatch) throw new Error(`Missing repository class in ${name}`);
  const repositoryClass = classMatch[1];
  const base = repositoryClass.slice(0, -'Repository'.length);
  const entityClass = `${base}Entity`;
  const mixin = `_${repositoryClass}Mixin`;

  const methods = [
    `get${base}`,
    `store${base}`,
    `update${base}`,
    `destroy${base}`,
    '_whereKey',
    ...(aliases[base] ?? []),
  ];
  if (base === 'CreatureTemplate') methods.push('_handleReservedWords');
  for (const method of new Set(methods)) {
    source = removeBlockMethod(source, method);
  }

  if (!source.includes('repository_annotations.dart')) {
    const entityImport =
      `import 'package:foxy/entity/${name.replace('_repository.dart', '_entity.dart')}';`;
    source = source.replace(
      entityImport,
      `${entityImport}\nimport 'package:foxy/infrastructure/codegen/repository_annotations.dart';`,
    );
  }
  if (!source.includes('mysql_error_util.dart')) {
    const annotationImport =
      "import 'package:foxy/infrastructure/codegen/repository_annotations.dart';";
    source = source.replace(
      annotationImport,
      `${annotationImport}\nimport 'package:foxy/infrastructure/database/mysql_error_util.dart';`,
    );
  }
  if (!source.includes(`part '${name.replace('.dart', '.g.dart')}';`)) {
    const imports = [...source.matchAll(/^import [^;]+;$/gm)];
    if (imports.length === 0) throw new Error(`Missing imports in ${name}`);
    const last = imports.at(-1);
    const index = last.index + last[0].length;
    source =
      source.slice(0, index) +
      `\n\npart '${name.replace('.dart', '.g.dart')}';` +
      source.slice(index);
  }
  if (!source.includes(`@FoxyRepository(${entityClass})`)) {
    source = source.replace(
      `class ${repositoryClass}`,
      `@FoxyRepository(${entityClass})\nclass ${repositoryClass}`,
    );
  }
  const refreshedClassIndex = source.indexOf(`class ${repositoryClass}`);
  const classBodyIndex = source.indexOf('{', refreshedClassIndex);
  const classHeader = source.slice(refreshedClassIndex, classBodyIndex);
  if (!classHeader.includes(mixin)) {
    source =
      source.slice(0, classBodyIndex).trimEnd() +
      `, ${mixin} ` +
      source.slice(classBodyIndex);
  }

  source = source.replace(/\n{3,}/g, '\n\n');
  fs.writeFileSync(filePath, source);
}

function dartFilesUnder(directory) {
  const result = [];
  for (const entry of fs.readdirSync(directory, {withFileTypes: true})) {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      result.push(...dartFilesUnder(entryPath));
    } else if (entry.name.endsWith('.dart')) {
      result.push(entryPath);
    }
  }
  return result;
}

const directRenames = new Map([
  ['getAchievementCriterion', 'getAchievementCriteria'],
  ['storeAchievementCriterion', 'storeAchievementCriteria'],
  ['updateAchievementCriterion', 'updateAchievementCriteria'],
  ['destroyAchievementCriterion', 'destroyAchievementCriteria'],
  ['getItemRandomProperty', 'getItemRandomProperties'],
  ['storeItemRandomProperty', 'storeItemRandomProperties'],
  ['updateItemRandomProperty', 'updateItemRandomProperties'],
  ['destroyItemRandomProperty', 'destroyItemRandomProperties'],
  ['getItemVisual', 'getItemVisuals'],
  ['storeItemVisual', 'storeItemVisuals'],
  ['updateItemVisual', 'updateItemVisuals'],
  ['destroyItemVisual', 'destroyItemVisuals'],
  ['getSoundProviderPreference', 'getSoundProviderPreferences'],
  ['storeSoundProviderPreference', 'storeSoundProviderPreferences'],
  ['updateSoundProviderPreference', 'updateSoundProviderPreferences'],
  ['destroySoundProviderPreference', 'destroySoundProviderPreferences'],
]);

for (const filePath of [
  ...dartFilesUnder(path.join(process.cwd(), 'lib')),
  ...dartFilesUnder(path.join(process.cwd(), 'test')),
]) {
  let source = fs.readFileSync(filePath, 'utf8');
  const original = source;
  for (const [from, to] of directRenames) {
    source = source.replaceAll(from, to);
  }
  if (!filePath.endsWith('loot_template_database_editing_contract_test.dart')) {
    const presentBases = lootBases.filter((base) =>
      source.includes(`${base}Repository`),
    );
    if (presentBases.length === 1) {
      const base = presentBases[0];
      source = source
        .replaceAll('getLootTemplate', `get${base}`)
        .replaceAll('storeLootTemplate', `store${base}`)
        .replaceAll('updateLootTemplate', `update${base}`)
        .replaceAll('destroyLootTemplate', `destroy${base}`);
    }
  }
  if (source !== original) fs.writeFileSync(filePath, source);
}

console.log(`Migrated ${targets.size} repositories`);
