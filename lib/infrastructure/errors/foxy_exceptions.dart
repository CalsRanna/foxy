/// Foxy 业务异常体系。
///
/// 历史教训:项目曾用 `StateError('中文消息')` 承载所有业务错误,151 种
/// 中文消息散布在 327 个文件里,调用方只能靠字符串判断语义。本文件把
/// 异常收敛为 sealed 语义类型 + 英文诊断信息,中文文案统一经
/// [foxyErrorMessage] 按类型映射——异常内禁止中文。
library;

import 'dart:io';

/// Foxy 业务异常基类。
///
/// [message] 为英文诊断信息,仅供日志定位;面向用户的中文文案一律经
/// [foxyErrorMessage] 映射。implements(而非 extends)Exception,避免
/// `Exception: ` 前缀污染 UI 展示。
sealed class FoxyException implements Exception {
  const FoxyException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// 记录不存在:查询未命中、并发下被其他操作修改或删除。
final class RecordNotFoundException extends FoxyException {
  const RecordNotFoundException(super.message);
}

/// 主键重复:MySQL duplicate entry,或手写重复性校验。
final class DuplicateKeyException extends FoxyException {
  const DuplicateKeyException(super.message);
}

/// 主键未在新建时显式分配。
final class InvalidPrimaryKeyException extends FoxyException {
  const InvalidPrimaryKeyException(super.message);
}

/// 同一操作正在进行中(提交/保存/导入/导出等互斥操作)。
final class BusyException extends FoxyException {
  const BusyException(super.message);
}

/// 父记录尚未加载(子表编辑器在父键就绪前被调用)。
final class ParentNotLoadedException extends FoxyException {
  const ParentNotLoadedException(super.message);
}

/// DBC/自增 ID 已耗尽或超出可引用范围。
final class IdExhaustedException extends FoxyException {
  const IdExhaustedException(super.message);
}

/// 输入或业务规则校验拒绝。
final class ValidationException extends FoxyException {
  const ValidationException(super.message);
}

/// 该表不支持自动复制(一对一关系/无自增主键等)。
final class CopyNotSupportedException extends FoxyException {
  const CopyNotSupportedException(super.message);
}

/// 数据库尚未连接。
final class DatabaseNotConnectedException extends FoxyException {
  const DatabaseNotConnectedException(super.message);
}

/// 异常 → 面向用户的中文文案。UI 展示错误的唯一入口。
///
/// 新增 [FoxyException] 子类时必须同步补充映射;未知/驱动异常原样
/// 展示 `$error`(与历史行为一致)。仅进日志的诊断信息请直接用
/// `error.toString()`(英文),不要经过本函数。
String foxyErrorMessage(Object error) => switch (error) {
  RecordNotFoundException() => '记录不存在，可能已被其他操作修改或删除',
  DuplicateKeyException() => '相同主键的记录已存在',
  InvalidPrimaryKeyException() => '主键必须在新建时显式分配',
  BusyException() => '操作正在执行，请稍候',
  ParentNotLoadedException() => '父记录尚未加载',
  IdExhaustedException() => '记录 ID 已用尽，无法继续新增',
  ValidationException() => '输入不合法，请检查后重试',
  CopyNotSupportedException() => '该操作不支持自动复制，请新增记录',
  DatabaseNotConnectedException() => '数据库未连接，请先连接数据库',
  // 内部编解码/参数错误与不变量违背:语义正确的 Dart 核心类型。
  ArgumentError() => '输入或参数不合法，请检查后重试',
  StateError() => '内部状态异常，请重试',
  FormatException() => '输入格式不正确，请检查后重试',
  FileSystemException() => '文件系统错误，请检查路径后重试',
  _ => '$error',
};
