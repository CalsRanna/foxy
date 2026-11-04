final class DbcFileException implements Exception {
  final String message;

  const DbcFileException(this.message);

  @override
  String toString() => 'DbcFileException: $message';
}
