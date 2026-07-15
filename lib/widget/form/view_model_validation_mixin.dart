/// ViewModel 字段校验的通用断言。
///
/// 具体业务规则应由模块自己的 validation mixin 组合这些断言，Entity 保持为
/// 纯数据对象。需要查询数据库的唯一性和引用约束通过 Repository 查询能力完成。
mixin ViewModelValidationMixin {
  void requirePositive(int value, String label) {
    if (value <= 0) throw StateError('$label必须大于 0');
  }

  void requireNonNegative(int value, String label) {
    if (value < 0) throw StateError('$label不能小于 0');
  }

  void requireIntRange(int value, int min, int max, String label) {
    if (value < min || value > max) {
      throw StateError('$label必须在 $min..$max 之间');
    }
  }

  void requireFinite(double value, String label) {
    if (!value.isFinite) throw StateError('$label必须是有限数值');
  }

  void requireKnownFlags(int value, int knownMask, String message) {
    if (value < 0 || (value & ~knownMask) != 0) throw StateError(message);
  }

  void requireAllowedValue<T>(
    T value,
    Iterable<T> allowedValues,
    String message,
  ) {
    if (!allowedValues.contains(value)) throw StateError(message);
  }
}
