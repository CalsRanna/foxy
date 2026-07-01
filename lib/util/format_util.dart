/// 数值格式化工具。
///
/// [formatNum] 将数值转为字符串，并对 double 裁掉小数点后多余的尾随 0
/// （如 `1.50 → 1.5`、`2.0 → 2`）。整数原样输出。
///
/// 此前该逻辑以私有 `_fmt`/`_format` 的形式被复制到 ~60 个 view model 中，
/// 且每次调用都重新编译两个 RegExp。这里集中一份实现，并改用手动裁剪
/// （无正则）以消除每次调用的编译开销——填充详情表单时每个数值字段都会
/// 调用它，累积可观。
String formatNum(num v) {
  if (v is! double) return v.toString();
  final s = v.toString();
  // 仅当形如 "x.y...0" 时才需要裁剪；否则（无小数点、或不以 0 结尾）直接返回。
  final dot = s.indexOf('.');
  if (dot < 0 || !s.endsWith('0')) return s;
  // 从末尾向前裁掉多余的 0；若小数部分全为 0，连同小数点一并去掉。
  var end = s.length;
  while (end > dot + 1 && s.codeUnitAt(end - 1) == 0x30) {
    end--;
  }
  if (end == dot + 1) end = dot; // 小数部分被裁空 → 去掉小数点
  return s.substring(0, end);
}
