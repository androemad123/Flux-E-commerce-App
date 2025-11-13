import 'package:equatable/equatable.dart';
import '../../../data/models/shared_cart.dart';
import '../../../data/models/shared_cart_item.dart';

abstract class SharedCartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SharedCartInitial extends SharedCartState {}

class SharedCartLoading extends SharedCartState {}

class SharedCartsLoaded extends SharedCartState {
  final List<SharedCart> carts;
  SharedCartsLoaded(this.carts);
  @override
  List<Object?> get props => [carts];
}

class SharedCartItemsLoaded extends SharedCartState {
  final String cartId;
  final List<SharedCartItem> items;
  SharedCartItemsLoaded({required this.cartId, required this.items});
  @override
  List<Object?> get props => [cartId, items];
}

class SharedCartCreated extends SharedCartState {
  final SharedCart cart;
  SharedCartCreated(this.cart);
  @override
  List<Object?> get props => [cart];
}

class SharedCartUpdated extends SharedCartState {}

class SharedCartDeleted extends SharedCartState {}

class SharedCartError extends SharedCartState {
  final String message;
  SharedCartError(this.message);
  @override
  List<Object?> get props => [message];
}

