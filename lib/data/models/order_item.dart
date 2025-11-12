import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
  final String productId;
  final String name;
  final String imageUrl;
  final double unitPrice;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;

  const OrderItem({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.unitPrice,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
  }) : assert(quantity > 0, 'Order item quantity must be greater than zero');

  double get lineTotal => unitPrice * quantity;

  OrderItem copyWith({
    String? productId,
    String? name,
    String? imageUrl,
    double? unitPrice,
    int? quantity,
    String? selectedColor,
    String? selectedSize,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'unitPrice': unitPrice,
      'quantity': quantity,
      if (selectedColor != null && selectedColor!.isNotEmpty)
        'selectedColor': selectedColor,
      if (selectedSize != null && selectedSize!.isNotEmpty)
        'selectedSize': selectedSize,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      productId: data['productId'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      unitPrice: (data['unitPrice'] != null)
          ? (data['unitPrice'] as num).toDouble()
          : 0.0,
      quantity: data['quantity'] ?? 0,
      selectedColor: data['selectedColor'],
      selectedSize: data['selectedSize'],
    );
  }

  @override
  List<Object?> get props => [
        productId,
        name,
        imageUrl,
        unitPrice,
        quantity,
        selectedColor,
        selectedSize
      ];
}
