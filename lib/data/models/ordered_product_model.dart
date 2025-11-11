class OrderedProduct {
  final String productId;
  final int quantity;
  final double price;

  OrderedProduct({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderedProduct.fromMap(Map<String, dynamic> data) {
    return OrderedProduct(
      productId: data['productId'] ?? '',
      quantity: data['quantity'] ?? 0,
      price: (data['price'] != null)
          ? (data['price'] as num).toDouble()
          : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}
