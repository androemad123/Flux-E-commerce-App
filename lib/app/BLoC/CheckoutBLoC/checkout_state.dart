import 'package:equatable/equatable.dart';

import '../../../data/models/cart_item.dart';
import '../../../data/models/delivery_address_model.dart';
import '../../../data/models/order_item.dart';
import '../../../data/models/order_model.dart';

enum CheckoutStatus {
  initial,
  ready,
  shippingCompleted,
  paymentSelected,
  submitting,
  success,
  failure,
}

class CheckoutState extends Equatable {
  const CheckoutState({
    this.status = CheckoutStatus.initial,
    this.cartItems = const [],
    this.address,
    this.shippingMethod,
    this.shippingFee = 0.0,
    this.paymentMethod,
    this.userId,
    this.order,
    this.errorMessage,
    this.sharedCartId,
  });

  final CheckoutStatus status;
  final List<CartItem> cartItems;
  final DeliveryAddress? address;
  final String? shippingMethod;
  final double shippingFee;
  final String? paymentMethod;
  final String? userId;
  final OrderModel? order;
  final String? errorMessage;
  final String? sharedCartId;

  double get subtotal =>
      cartItems.fold(0, (total, item) => total + item.subtotal);

  double get total => subtotal + shippingFee;

  List<OrderItem> get orderItems => cartItems
      .map(
        (cartItem) => OrderItem(
          productId: cartItem.product.ProductID,
          name: cartItem.product.ProductName,
          imageUrl: cartItem.product.getDisplayImage(),
          unitPrice: cartItem.product.ProductPrice,
          quantity: cartItem.quantity,
          selectedColor: cartItem.selectedColor,
          selectedSize: cartItem.selectedSize,
        ),
      )
      .toList();

  CheckoutState copyWith({
    CheckoutStatus? status,
    List<CartItem>? cartItems,
    DeliveryAddress? address,
    String? shippingMethod,
    double? shippingFee,
    String? paymentMethod,
    String? userId,
    OrderModel? order,
    String? errorMessage,
    String? sharedCartId,
    bool clearError = false,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      address: address ?? this.address,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      shippingFee: shippingFee ?? this.shippingFee,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      userId: userId ?? this.userId,
      order: order ?? this.order,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      sharedCartId: sharedCartId ?? this.sharedCartId,
    );
  }

  bool get isReadyToSubmit =>
      cartItems.isNotEmpty &&
      address != null &&
      shippingMethod != null &&
      paymentMethod != null;

  @override
  List<Object?> get props => [
        status,
        cartItems,
        address,
        shippingMethod,
        shippingFee,
        paymentMethod,
        userId,
        order,
        errorMessage,
        sharedCartId,
      ];
}
