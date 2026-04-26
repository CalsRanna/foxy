class Feature {
  final int id;
  final String name;
  final String description;
  final String icon;
  final String routerMenu;
  final String category;
  final bool isPinned;
  final bool isFavorite;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Feature({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.routerMenu,
    this.category = 'database',
    this.isPinned = false,
    this.isFavorite = false,
    this.sortOrder = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      routerMenu: json['router_menu'] as String,
      category: (json['category'] as String?) ?? 'database',
      isPinned: json['is_pinned'] == 1 || json['is_pinned'] == true,
      isFavorite: json['is_favorite'] == 1 || json['is_favorite'] == true,
      sortOrder: (json['sort_order'] as int?) ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'router_menu': routerMenu,
      'category': category,
      'is_pinned': isPinned ? 1 : 0,
      'is_favorite': isFavorite ? 1 : 0,
      'sort_order': sortOrder,
    };
  }

  Feature copyWith({
    int? id,
    String? name,
    String? description,
    String? icon,
    String? routerMenu,
    String? category,
    bool? isPinned,
    bool? isFavorite,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Feature(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      routerMenu: routerMenu ?? this.routerMenu,
      category: category ?? this.category,
      isPinned: isPinned ?? this.isPinned,
      isFavorite: isFavorite ?? this.isFavorite,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
