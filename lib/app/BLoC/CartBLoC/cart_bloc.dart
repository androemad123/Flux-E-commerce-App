import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<CartStarted>(_onCartStarted);
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemRemoved>(_onCartItemRemoved);
    on<CartItemQuantityUpdated>(_onCartItemQuantityUpdated);
    on<CartCleared>(_onCartCleared);
  }

  void _onCartStarted(CartStarted event, Emitter<CartState> emit) {
    emit(state.copyWith(status: CartStatus.success, items: state.items));
  }

  void _onCartItemAdded(
    CartItemAdded event,
    Emitter<CartState> emit,
  ) {
    final updatedItems = List<CartItem>.from(state.items);

    final existingIndex = updatedItems.indexWhere(
      (item) =>
          item.product.ProductID == event.product.ProductID &&
          item.selectedColor == event.selectedColor &&
          item.selectedSize == event.selectedSize,
    );

    if (existingIndex != -1) {
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + event.quantity,
      );
    } else {
      updatedItems.add(
        CartItem(
          product: event.product,
          selectedColor: event.selectedColor,
          selectedSize: event.selectedSize,
          quantity: event.quantity,
        ),
      );
    }

    emit(
      state.copyWith(
        status: CartStatus.success,
        items: updatedItems,
      ),
    );
  }

  void _onCartItemRemoved(
    CartItemRemoved event,
    Emitter<CartState> emit,
  ) {
    final updatedItems = state.items.where((item) {
      final matchesProduct = item.product.ProductID == event.productId;
      final matchesColor = item.selectedColor == event.selectedColor;
      final matchesSize = item.selectedSize == event.selectedSize;
      return !(matchesProduct &&
          (event.selectedColor == null || matchesColor) &&
          (event.selectedSize == null || matchesSize));
    }).toList();

    emit(
      state.copyWith(
        status: CartStatus.success,
        items: updatedItems,
      ),
    );
  }

  void _onCartItemQuantityUpdated(
    CartItemQuantityUpdated event,
    Emitter<CartState> emit,
  ) {
    final updatedItems = List<CartItem>.from(state.items);

    final index = updatedItems.indexWhere(
      (item) =>
          item.product.ProductID == event.productId &&
          item.selectedColor == event.selectedColor &&
          item.selectedSize == event.selectedSize,
    );

    if (index == -1) {
      return;
    }

    if (event.quantity <= 0) {
      updatedItems.removeAt(index);
    } else {
      updatedItems[index] =
          updatedItems[index].copyWith(quantity: event.quantity);
    }

    emit(
      state.copyWith(
        status: CartStatus.success,
        items: updatedItems,
      ),
    );
  }

  void _onCartCleared(
    CartCleared event,
    Emitter<CartState> emit,
  ) {
    emit(
      state.copyWith(
        status: CartStatus.success,
        items: const [],
      ),
    );
  }
}
