import 'package:equatable/equatable.dart';

import '../../../data/models/cart_item.dart';
import '../../../data/models/delivery_address_model.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class CheckoutStarted extends CheckoutEvent {
  const CheckoutStarted({
    required this.cartItems,
    this.userId,
  });

  final List<CartItem> cartItems;
  final String? userId;

  @override
  List<Object?> get props => [cartItems, userId];
}

class CheckoutShippingSubmitted extends CheckoutEvent {
  const CheckoutShippingSubmitted({
    required this.address,
    required this.shippingMethod,
    required this.shippingFee,
  });

  final DeliveryAddress address;
  final String shippingMethod;
  final double shippingFee;

  @override
  List<Object?> get props => [address, shippingMethod, shippingFee];
}

class CheckoutPaymentMethodSelected extends CheckoutEvent {
  const CheckoutPaymentMethodSelected(this.paymentMethod);

  final String paymentMethod;

  @override
  List<Object?> get props => [paymentMethod];
}

class CheckoutOrderPlaced extends CheckoutEvent {
  const CheckoutOrderPlaced();
}

class CheckoutReset extends CheckoutEvent {
  const CheckoutReset();
}
