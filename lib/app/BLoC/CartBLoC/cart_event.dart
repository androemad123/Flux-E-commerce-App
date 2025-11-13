import 'package:equatable/equatable.dart';

import '../../../data/models/ProductModel.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartStarted extends CartEvent {
  const CartStarted();
}

class CartItemAdded extends CartEvent {
  final Product product;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;

  const CartItemAdded({
    required this.product,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
  }) : assert(quantity > 0, 'Quantity must be greater than zero');

  @override
  List<Object?> get props => [
        product.ProductID,
        quantity,
        selectedColor,
        selectedSize,
      ];
}

class CartItemRemoved extends CartEvent {
  final String productId;
  final String? selectedColor;
  final String? selectedSize;

  const CartItemRemoved({
    required this.productId,
    this.selectedColor,
    this.selectedSize,
  });

  @override
  List<Object?> get props => [productId, selectedColor, selectedSize];
}

class CartItemQuantityUpdated extends CartEvent {
  final String productId;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;

  const CartItemQuantityUpdated({
    required this.productId,
    required this.quantity,
    this.selectedColor,
    this.selectedSize,
  }) : assert(quantity >= 0, 'Quantity must be non-negative');

  @override
  List<Object?> get props => [
        productId,
        quantity,
        selectedColor,
        selectedSize,
      ];
}

class CartCleared extends CartEvent {
  const CartCleared();
}
