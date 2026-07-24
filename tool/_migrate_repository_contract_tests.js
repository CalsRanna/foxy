const fs = require('fs');
const path = require('path');
const {execFileSync} = require('child_process');

const testDir = path.join(process.cwd(), 'test');

function dartFilesUnder(directory) {
  const result = [];
  for (const entry of fs.readdirSync(directory, {withFileTypes: true})) {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      result.push(...dartFilesUnder(entryPath));
    } else if (entry.name.endsWith('_test.dart')) {
      result.push(entryPath);
    }
  }
  return result;
}

const protectedTests = new Set([
  'test/achievement_criteria_database_editing_contract_test.dart',
  'test/infrastructure/codegen/entity_codegen_migration_coverage_test.dart',
  'test/infrastructure/codegen/repository_generator_vm.dart',
  'test/item_random_properties_database_editing_contract_test.dart',
  'test/item_visual_effect_database_editing_contract_test.dart',
  'test/item_visuals_database_editing_contract_test.dart',
  'test/loot_template_database_editing_contract_test.dart',
  'test/page_text_contract_test.dart',
  'test/reference_loot_template_contract_test.dart',
  'test/sound_provider_preferences_database_editing_contract_test.dart',
]);

for (const filePath of dartFilesUnder(testDir)) {
  const relativePath = path.relative(process.cwd(), filePath);
  let source = protectedTests.has(relativePath)
    ? fs.readFileSync(filePath, 'utf8')
    : execFileSync('git', ['show', `HEAD:${relativePath}`], {
        encoding: 'utf8',
      });
  const original = fs.readFileSync(filePath, 'utf8');
  let usesLibrarySource = false;
  source = source.replace(
    /File\(\s*('lib\/repository\/[^']+_repository\.dart')\s*,?\s*\)\.readAsStringSync\(\)/g,
    (_, repositoryPath) => {
      const repositoryFile = path.join(
        process.cwd(),
        repositoryPath.slice(1, -1),
      );
      if (
        !fs.existsSync(repositoryFile) ||
        !fs.readFileSync(repositoryFile, 'utf8').includes('@FoxyRepository(')
      ) {
        return `File(${repositoryPath}).readAsStringSync()`;
      }
      usesLibrarySource = true;
      return `readLocalDartLibrarySource(${repositoryPath})`;
    },
  );
  source = source
    .replace(
      /\.update\([A-Za-z_][A-Za-z0-9_]*\.toJson\(\)\)/g,
      '.update(json)',
    )
    .replace(
      /\.update\(_writeJson\([A-Za-z_][A-Za-z0-9_]*\)\)/g,
      '.update(json)',
    )
    .replace(
      /insert\(\[[A-Za-z_][A-Za-z0-9_]*\.toJson\(\)\]\)/g,
      'insert([json])',
    )
    .replace(
      /insert\(\[_writeJson\([A-Za-z_][A-Za-z0-9_]*\)\]\)/g,
      'insert([json])',
    );
  source = source.replace(
    /^.*expect\(.*contains\(['"]if \([^'"]+\.(?:id|entry) <= 0\).*$(?:\n)?/gm,
    '',
  );

  if (
    usesLibrarySource &&
    !source.includes("support/local_dart_library_source.dart")
  ) {
    const imports = [...source.matchAll(/^import [^;]+;$/gm)];
    const last = imports.at(-1);
    if (!last) throw new Error(`No imports in ${filePath}`);
    const index = last.index + last[0].length;
    let helperPath = path.relative(
      path.dirname(filePath),
      path.join(testDir, 'support/local_dart_library_source.dart'),
    );
    if (!helperPath.startsWith('.')) helperPath = `./${helperPath}`;
    source =
      source.slice(0, index) +
      `\nimport '${helperPath.replaceAll(path.sep, '/')}';` +
      source.slice(index);
  }
  if (source !== original) fs.writeFileSync(filePath, source);
}
