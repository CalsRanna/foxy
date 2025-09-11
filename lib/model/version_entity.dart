class VersionEntity {
  String coreVersion = '';
  String coreRevision = '';
  String dbVersion = '';
  int cacheId = 0;

  VersionEntity();

  VersionEntity.fromJson(Map<String, dynamic> json) {
    coreVersion = json['core_version'] ?? '';
    coreRevision = json['core_revision'] ?? '';
    dbVersion = json['db_version'] ?? '';
    cacheId = json['cache_id'] ?? 0;
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
