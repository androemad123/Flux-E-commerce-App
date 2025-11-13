class SharedCart {
  final String id;
  final String name;
  final String owner; // user ID
  final List<String> collabs; // list of user IDs
  final DateTime createdAt;
  final DateTime? updatedAt;

  SharedCart({
    required this.id,
    required this.name,
    required this.owner,
    required this.collabs,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'owner': owner,
      'collabs': collabs,
      'createdAt': createdAt.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  factory SharedCart.fromMap(Map<String, dynamic> map, String id) {
    return SharedCart(
      id: id,
      name: map['name'] ?? '',
      owner: map['owner'] ?? '',
      collabs: List<String>.from(map['collabs'] ?? []),
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
    );
  }

  SharedCart copyWith({
    String? id,
    String? name,
    String? owner,
    List<String>? collabs,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SharedCart(
      id: id ?? this.id,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      collabs: collabs ?? this.collabs,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

