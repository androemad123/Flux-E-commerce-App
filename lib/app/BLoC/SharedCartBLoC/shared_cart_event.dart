import 'package:equatable/equatable.dart';
import '../../../data/models/shared_cart_item.dart';

abstract class SharedCartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSharedCarts extends SharedCartEvent {
  final String userId;
  LoadSharedCarts(this.userId);
  @override
  List<Object?> get props => [userId];
}

class CreateSharedCart extends SharedCartEvent {
  final String name;
  final String ownerId;
  CreateSharedCart({required this.name, required this.ownerId});
  @override
  List<Object?> get props => [name, ownerId];
}

class LoadSharedCartItems extends SharedCartEvent {
  final String cartId;
  LoadSharedCartItems(this.cartId);
  @override
  List<Object?> get props => [cartId];
}

class AddItemToSharedCart extends SharedCartEvent {
  final String cartId;
  final SharedCartItem item;
  AddItemToSharedCart({required this.cartId, required this.item});
  @override
  List<Object?> get props => [cartId, item];
}

class UpdateSharedCartItemQuantity extends SharedCartEvent {
  final String cartId;
  final String itemId;
  final int quantity;
  UpdateSharedCartItemQuantity({
    required this.cartId,
    required this.itemId,
    required this.quantity,
  });
  @override
  List<Object?> get props => [cartId, itemId, quantity];
}

class RemoveItemFromSharedCart extends SharedCartEvent {
  final String cartId;
  final String itemId;
  RemoveItemFromSharedCart({required this.cartId, required this.itemId});
  @override
  List<Object?> get props => [cartId, itemId];
}

class AddCollaborator extends SharedCartEvent {
  final String cartId;
  final String userId;
  AddCollaborator({required this.cartId, required this.userId});
  @override
  List<Object?> get props => [cartId, userId];
}

class RemoveCollaborator extends SharedCartEvent {
  final String cartId;
  final String userId;
  RemoveCollaborator({required this.cartId, required this.userId});
  @override
  List<Object?> get props => [cartId, userId];
}

class DeleteSharedCart extends SharedCartEvent {
  final String cartId;
  DeleteSharedCart(this.cartId);
  @override
  List<Object?> get props => [cartId];
}

class ClearSharedCartItems extends SharedCartEvent {
  final String cartId;
  ClearSharedCartItems(this.cartId);
  @override
  List<Object?> get props => [cartId];
}

