import 'package:equatable/equatable.dart';

import 'ProductModel.dart';

class CartItem extends Equatable {
  final Product product;
  final String? selectedColor;
  final String? selectedSize;
  final int quantity;

  const CartItem({
    required this.product,
    this.selectedColor,
    this.selectedSize,
    this.quantity = 1,
  }) : assert(quantity > 0, 'Cart item quantity must be greater than zero');

  double get subtotal => product.ProductPrice * quantity;

  CartItem copyWith({
    Product? product,
    String? selectedColor,
    String? selectedSize,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        product.ProductID,
        selectedColor,
        selectedSize,
        quantity,
      ];
}
