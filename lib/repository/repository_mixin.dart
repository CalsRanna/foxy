import 'package:foxy/database/database.dart';
import 'package:laconic/laconic.dart';

mixin RepositoryMixin {
  Laconic get laconic => Database.instance.laconic;
  final kPageSize = 50;
}
