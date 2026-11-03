/// A paginated row record.
class SignedEntityBrief {
  final int id;
  final String name;

  const SignedEntityBrief({required this.id, required this.name});
}

/// One side's data source for the signed-route picker: pure data + query
/// closures, shareable by multiple pickers.
class SignedEntitySource {
  final String title;
  final String errorLabel;
  final Future<List<SignedEntityBrief>> Function(
    int page,
    String id,
    String name,
  )
  fetch;
  final Future<int> Function(String id, String name) count;

  const SignedEntitySource({
    required this.title,
    required this.errorLabel,
    required this.fetch,
    required this.count,
  });
}
