class VersionEntity {
  final String coreVersion;
  final String coreRevision;
  final String dbVersion;
  final int cacheId;

  const VersionEntity({
    this.coreVersion = '',
    this.coreRevision = '',
    this.dbVersion = '',
    this.cacheId = 0,
  });

  factory VersionEntity.fromJson(Map<String, dynamic> json) {
    return VersionEntity(
      coreVersion: json['core_version'] ?? '',
      coreRevision: json['core_revision'] ?? '',
      dbVersion: json['db_version'] ?? '',
      cacheId: json['cache_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'core_version': coreVersion,
      'core_revision': coreRevision,
      'db_version': dbVersion,
      'cache_id': cacheId,
    };
  }
}
