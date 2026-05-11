#!/usr/bin/env python3
"""将 lib/page/ 下所有 ViewModel 的 Repository() 直接构造替换为 GetIt DI 获取。"""
import re, os, glob

PAGE_DIR = 'lib/page'

def transform_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original = content

    # 找出文件中所有 XxxRepository() 的使用
    repo_usages = {}
    # 匹配: 任意名字 = XxxRepository(); — 捕获变量名、Repo类型
    for m in re.finditer(r'(?P<indent>\s*)final\s+(?P<var>\w+)\s*=\s*(?P<repo>\w+Repository)\(\);?', content):
        indent = m.group('indent')
        var = m.group('var')
        repo = m.group('repo')
        line = m.group(0)
        if repo not in repo_usages:
            repo_usages[repo] = []
        repo_usages[repo].append({
            'indent': indent,
            'var': var,
            'line': line,
            'is_field': len(indent) <= 4,  # 类字段通常 2 空格
        })

    # 匹配内联: XxxRepository().method
    inline_patterns = re.finditer(r'(?P<repo>\w+Repository)\(\)\.(?P<method>\w+)', content)
    for m in inline_patterns:
        repo = m.group('repo')
        if repo not in repo_usages:
            repo_usages[repo] = []
        repo_usages[repo].append({
            'indent': '',
            'var': '',
            'line': m.group(0),
            'is_field': False,
            'is_inline': True,
        })

    if not repo_usages:
        return False

    # 对每种 Repository 类型，确定字段名
    field_names = {}  # repo_type -> field_name
    fields_to_add = []  # (repo_type, field_name) to insert at class top

    for repo, usages in repo_usages.items():
        # 检查是否已有字段
        field_usage = next((u for u in usages if u.get('is_field')), None)
        inline_usages = [u for u in usages if u.get('is_inline')]
        local_usages = [u for u in usages if not u.get('is_field') and not u.get('is_inline')]

        if field_usage:
            # 已有字段 — 统一字段名（确保以 _ 开头）
            var_name = field_usage['var']
            if not var_name.startswith('_'):
                var_name = '_' + var_name
            field_names[repo] = var_name

            # 如果字段声明还没改成 DI 形式，替换它
            old_decl = f"final {field_usage['var']} = {repo}();"
            new_decl = f"final {var_name} = GetIt.instance.get<{repo}>();"
            content = content.replace(old_decl, new_decl)

            # 如果是 _repository（已经是 _开头），字段名不变
            if field_usage['var'] != var_name:
                # 替换类中所有对该字段的引用（小心，不要替换 local 变量）
                # 只替换在类体范围的使用
                content = content.replace(f"{field_usage['var']}.", f"{var_name}.")
        else:
            # 没有字段 — 需要新增
            var_name = '_repository'
            # 如果已有其他 repo 用了 _repository，则用 repo 名生成
            if var_name in field_names.values():
                # 从 Repo 类名生成: CreatureTemplateRepository -> _creatureRepo
                short = re.sub(r'Repository$', '', repo)
                var_name = '_' + re.sub(r'([A-Z])', r'_\1', short).lower().strip('_')
                var_name = re.sub(r'_+', '_', var_name)  # 合并连续下划线
                if not var_name.startswith('_'):
                    var_name = '_' + var_name
                # 再转驼峰为下划线
                parts = re.findall(r'[A-Z][a-z]*', short)
                var_name = '_' + '_'.join(p.lower() for p in parts) + '_repo'

            field_names[repo] = var_name
            fields_to_add.append((repo, var_name))

        # 删除方法内的局部变量声明
        for usage in local_usages:
            content = content.replace('\n' + usage['line'] + '\n', '\n')
            # 同时替换该局部变量的引用
            if usage['var'] != var_name:
                content = content.replace(f"{usage['var']}.", f"{var_name}.")

        # 替换内联调用: XxxRepository().method -> _repository.method
        for usage in inline_usages:
            content = content.replace(usage['line'], f"{var_name}.{usage['line'].split('.', 1)[1]}")

    # 如果所有 usages 都是内联（没有局部变量也没有字段），且需要新增字段
    # fields_to_add 非空
    # 把字段插入到类体开头（第一个现有字段之后）
    if fields_to_add:
        # 找类声明后的位置插入字段
        for repo, var_name in fields_to_add:
            # 在第一个 'final' 字段附近插入，或者直接在类声明后
            # 更稳妥：在 'class Xxx' 下一行插入
            class_match = re.search(r'(class \w+.*?\{)\s*\n', content)
            if class_match:
                insert_pos = class_match.end()
                new_field_line = f'  final {var_name} = GetIt.instance.get<{repo}>();\n'
                content = content[:insert_pos] + new_field_line + content[insert_pos:]

    # 确保有 get_it import
    if "import 'package:get_it/get_it.dart';" not in content:
        # 在最后一个 package: 导入后插入
        last_import = list(re.finditer(r"^import 'package:.*';$", content, re.MULTILINE))
        if last_import:
            pos = last_import[-1].end()
            content = content[:pos] + "\nimport 'package:get_it/get_it.dart';" + content[pos:]

    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False


if __name__ == '__main__':
    files = glob.glob(f'{PAGE_DIR}/**/*.dart', recursive=True)
    changed = 0
    for fp in sorted(files):
        if transform_file(fp):
            print(f'  CHANGED: {fp}')
            changed += 1
    print(f'\nDone: {changed} files changed')
