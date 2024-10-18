// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$creatureTemplatesNotifierHash() =>
    r'75a1e8c3e3120b7bfe4c8718d724e4ba1cb1f9d4';

/// See also [CreatureTemplatesNotifier].
@ProviderFor(CreatureTemplatesNotifier)
final creatureTemplatesNotifierProvider = AsyncNotifierProvider<
    CreatureTemplatesNotifier, List<BriefCreatureTemplate>>.internal(
  CreatureTemplatesNotifier.new,
  name: r'creatureTemplatesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$creatureTemplatesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreatureTemplatesNotifier
    = AsyncNotifier<List<BriefCreatureTemplate>>;
String _$creatureTemplateTotalNotifierHash() =>
    r'6572be02cc291941caa1ab66efe9c1f5310f4bba';

/// See also [CreatureTemplateTotalNotifier].
@ProviderFor(CreatureTemplateTotalNotifier)
final creatureTemplateTotalNotifierProvider =
    AsyncNotifierProvider<CreatureTemplateTotalNotifier, int>.internal(
  CreatureTemplateTotalNotifier.new,
  name: r'creatureTemplateTotalNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$creatureTemplateTotalNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreatureTemplateTotalNotifier = AsyncNotifier<int>;
String _$creatureTemplatePageNotifierHash() =>
    r'a6bf67e4d50f1587191aba40f1b77400bbdad495';

/// See also [CreatureTemplatePageNotifier].
@ProviderFor(CreatureTemplatePageNotifier)
final creatureTemplatePageNotifierProvider =
    NotifierProvider<CreatureTemplatePageNotifier, int>.internal(
  CreatureTemplatePageNotifier.new,
  name: r'creatureTemplatePageNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$creatureTemplatePageNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreatureTemplatePageNotifier = Notifier<int>;
String _$creatureTemplateNotifierHash() =>
    r'b80e1d112e8387690c9bfa859fe07ad53ba8aad0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CreatureTemplateNotifier
    extends BuildlessAutoDisposeAsyncNotifier<CreatureTemplate> {
  late final int? entry;

  FutureOr<CreatureTemplate> build(
    int? entry,
  );
}

/// See also [CreatureTemplateNotifier].
@ProviderFor(CreatureTemplateNotifier)
const creatureTemplateNotifierProvider = CreatureTemplateNotifierFamily();

/// See also [CreatureTemplateNotifier].
class CreatureTemplateNotifierFamily
    extends Family<AsyncValue<CreatureTemplate>> {
  /// See also [CreatureTemplateNotifier].
  const CreatureTemplateNotifierFamily();

  /// See also [CreatureTemplateNotifier].
  CreatureTemplateNotifierProvider call(
    int? entry,
  ) {
    return CreatureTemplateNotifierProvider(
      entry,
    );
  }

  @override
  CreatureTemplateNotifierProvider getProviderOverride(
    covariant CreatureTemplateNotifierProvider provider,
  ) {
    return call(
      provider.entry,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'creatureTemplateNotifierProvider';
}

/// See also [CreatureTemplateNotifier].
class CreatureTemplateNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CreatureTemplateNotifier,
        CreatureTemplate> {
  /// See also [CreatureTemplateNotifier].
  CreatureTemplateNotifierProvider(
    int? entry,
  ) : this._internal(
          () => CreatureTemplateNotifier()..entry = entry,
          from: creatureTemplateNotifierProvider,
          name: r'creatureTemplateNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$creatureTemplateNotifierHash,
          dependencies: CreatureTemplateNotifierFamily._dependencies,
          allTransitiveDependencies:
              CreatureTemplateNotifierFamily._allTransitiveDependencies,
          entry: entry,
        );

  CreatureTemplateNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.entry,
  }) : super.internal();

  final int? entry;

  @override
  FutureOr<CreatureTemplate> runNotifierBuild(
    covariant CreatureTemplateNotifier notifier,
  ) {
    return notifier.build(
      entry,
    );
  }

  @override
  Override overrideWith(CreatureTemplateNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreatureTemplateNotifierProvider._internal(
        () => create()..entry = entry,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        entry: entry,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CreatureTemplateNotifier,
      CreatureTemplate> createElement() {
    return _CreatureTemplateNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreatureTemplateNotifierProvider && other.entry == entry;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, entry.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreatureTemplateNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<CreatureTemplate> {
  /// The parameter `entry` of this provider.
  int? get entry;
}

class _CreatureTemplateNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CreatureTemplateNotifier,
        CreatureTemplate> with CreatureTemplateNotifierRef {
  _CreatureTemplateNotifierProviderElement(super.provider);

  @override
  int? get entry => (origin as CreatureTemplateNotifierProvider).entry;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
