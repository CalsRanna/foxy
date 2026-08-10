/// Foxy business-exception system.
///
/// Historical lesson: the project once carried every business error via
/// `StateError('Chinese message')`, with 151 distinct Chinese messages
/// scattered across 327 files and callers relying on string matching to
/// infer semantics. This file converges exceptions into sealed semantic
/// types plus English diagnostics; Chinese copy is mapped by type through
/// [FoxyError.message] — Chinese is forbidden inside exceptions.
library;

import 'dart:io';

/// Base class of Foxy business exceptions.
///
/// [message] is an English diagnostic for log tracing only; user-facing
/// Chinese copy always goes through [FoxyError.message]. implements (not
/// extends) Exception so the `Exception: ` prefix never pollutes the UI.
sealed class FoxyException implements Exception {
  const FoxyException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Record not found: query missed, or modified/deleted concurrently by
/// another operation.
final class RecordNotFoundException extends FoxyException {
  const RecordNotFoundException(super.message);
}

/// Duplicate primary key: a MySQL duplicate entry, or a hand-written
/// uniqueness check.
final class DuplicateKeyException extends FoxyException {
  const DuplicateKeyException(super.message);
}

/// Primary key was not explicitly assigned on create.
final class InvalidPrimaryKeyException extends FoxyException {
  const InvalidPrimaryKeyException(super.message);
}

/// The same operation is already in progress (mutually exclusive
/// operations such as commit/save/import/export).
final class BusyException extends FoxyException {
  const BusyException(super.message);
}

/// Linked record not loaded yet (a linked editor was invoked before its
/// link key was ready).
final class LinkNotLoadedException extends FoxyException {
  const LinkNotLoadedException(super.message);
}

/// DBC/auto-increment IDs exhausted or beyond the referenceable range.
final class IdExhaustedException extends FoxyException {
  const IdExhaustedException(super.message);
}

/// Rejected by input or business-rule validation.
final class ValidationException extends FoxyException {
  const ValidationException(super.message);
}

/// This table does not support automatic copy (one-to-one relations, no
/// auto-increment primary key, etc.).
final class CopyNotSupportedException extends FoxyException {
  const CopyNotSupportedException(super.message);
}

/// The database is not connected yet.
final class DatabaseNotConnectedException extends FoxyException {
  const DatabaseNotConnectedException(super.message);
}

/// Update flow failed: any failure in the check, download, verify or
/// extract stage.
final class UpdateException extends FoxyException {
  const UpdateException(this.code, super.message);

  /// Failure category, used for copy mapping and diagnostics.
  final UpdateErrorKind code;
}

/// Update failure categories.
enum UpdateErrorKind {
  /// Network request failed (timeout, connection failure, non-200
  /// response).
  network,

  /// Manifest content invalid (missing fields, malformed format,
  /// unparseable version).
  invalidManifest,

  /// Downloaded file failed verification (SHA-256 or size mismatch).
  verification,

  /// Extraction or disk write failed.
  fileSystem,

  /// Update cancelled by the user.
  canceled,
}

/// Exception → user-facing Chinese copy. The single entry point for UI
/// error display.
///
/// Adding a [FoxyException] subclass requires a matching mapping entry;
/// unknown/driver exceptions display `$error` verbatim (matching legacy
/// behavior). Diagnostic info destined only for logs should use
/// `error.toString()` (English) directly, not this function.
abstract final class FoxyError {
  static String message(Object error) => switch (error) {
    RecordNotFoundException() => '记录不存在，可能已被其他操作修改或删除',
    DuplicateKeyException() => '相同主键的记录已存在',
    InvalidPrimaryKeyException() => '主键必须在新建时显式分配',
    BusyException() => '操作正在执行，请稍候',
    LinkNotLoadedException() => '关联记录尚未加载',
    IdExhaustedException() => '记录 ID 已用尽，无法继续新增',
    ValidationException() => '输入不合法，请检查后重试',
    CopyNotSupportedException() => '该操作不支持自动复制，请新增记录',
    DatabaseNotConnectedException() => '数据库未连接，请先连接数据库',
    UpdateException(:final code) => switch (code) {
      UpdateErrorKind.network => '无法连接更新服务器，请检查网络后重试',
      UpdateErrorKind.invalidManifest => '更新信息无效，请稍后重试',
      UpdateErrorKind.verification => '更新文件校验失败，请重试',
      UpdateErrorKind.fileSystem => '更新文件写入失败，请检查磁盘空间后重试',
      UpdateErrorKind.canceled => '更新已取消',
    },
    // Internal encode/decode or argument errors and invariant violations:
    // semantically correct Dart core types.
    ArgumentError() => '输入或参数不合法，请检查后重试',
    StateError() => '内部状态异常，请重试',
    FormatException() => '输入格式不正确，请检查后重试',
    FileSystemException() => '文件系统错误，请检查路径后重试',
    _ => '$error',
  };
}
