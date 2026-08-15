import 'package:foxy/constant/flag_item.dart';

/// The kind of editor an integer physical column should currently use.
///
/// The four states are mutually exclusive, decided uniquely by the concrete
/// subtype of [IntegerFieldSpec], replacing the old nullable
/// `reference/options/flags` combination inference.
enum IntegerFieldEditor { number, select, flags, reference }

/// Edit spec of a dynamic integer field: describes "which existing
/// component edits this integer column".
///
/// [R] is the reference enum (e.g. [GameObjectDataReference]); only the
/// reference subtype actually uses it.
/// This is a pure data class with no Flutter dependency; the View's
/// exhaustive switch renders it as the corresponding existing component.
sealed class IntegerFieldSpec<R> {
  final String label;

  const IntegerFieldSpec(this.label);

  IntegerFieldEditor get editor;
}

/// Bit-flag picker ([FoxyFlagPicker]).
final class IntegerFlagsFieldSpec<R> extends IntegerFieldSpec<R> {
  final List<FlagItem> flags;

  const IntegerFlagsFieldSpec(super.label, {required this.flags});

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.flags;
}

/// Plain integer input ([FoxyNumberInput]).
final class IntegerNumberFieldSpec<R> extends IntegerFieldSpec<R> {
  const IntegerNumberFieldSpec(super.label);

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.number;
}

/// Entity-reference picker ([FoxyEntityPicker]).
final class IntegerReferenceFieldSpec<R> extends IntegerFieldSpec<R> {
  final R reference;

  const IntegerReferenceFieldSpec(super.label, {required this.reference});

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.reference;
}

/// Strict enum dropdown ([FoxyShadSelect]).
final class IntegerSelectFieldSpec<R> extends IntegerFieldSpec<R> {
  final Map<int, String> options;

  const IntegerSelectFieldSpec(super.label, {required this.options});

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.select;
}
