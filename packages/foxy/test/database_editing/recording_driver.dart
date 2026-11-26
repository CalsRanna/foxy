import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

class RecordingDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();

  final int affectedRows;
  final Object? error;

  RecordingDriver({this.affectedRows = 1, this.error});

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    if (error case final failure?) throw failure;
    return affectedRows;
  }

  @override
  Future<void> close() async {}

  @override
  Future<int> insertAndGetId(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    if (error case final failure?) throw failure;
    return 1;
  }

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async => const [];

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {
    if (error case final failure?) throw failure;
  }

  @override
  Future<T> transaction<T>(Future<T> Function() action) => action();
}
