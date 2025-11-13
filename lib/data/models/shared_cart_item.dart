class SharedCartItem {
  final String? id; // Firestore document ID
  final String productId;
  final int quantity;
  final String addedBy; // user ID

  SharedCartItem({
    this.id,
    required this.productId,
    required this.quantity,
    required this.addedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'addedBy': addedBy,
    };
  }

  factory SharedCartItem.fromMap(Map<String, dynamic> map) {
    return SharedCartItem(
      id: map['id'] as String?,
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 0,
      addedBy: map['addedBy'] ?? '',
    );
  }

  SharedCartItem copyWith({
    String? id,
    String? productId,
    int? quantity,
    String? addedBy,
  }) {
    return SharedCartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      addedBy: addedBy ?? this.addedBy,
    );
  }
}

