import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/shared_cart.dart';
import '../../../data/models/shared_cart_item.dart';
import 'shared_cart_event.dart';
import 'shared_cart_state.dart';

class SharedCartBloc extends Bloc<SharedCartEvent, SharedCartState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SharedCartBloc() : super(SharedCartInitial()) {
    on<LoadSharedCarts>(_onLoadSharedCarts);
    on<CreateSharedCart>(_onCreateSharedCart);
    on<LoadSharedCartItems>(_onLoadSharedCartItems);
    on<AddItemToSharedCart>(_onAddItemToSharedCart);
    on<UpdateSharedCartItemQuantity>(_onUpdateSharedCartItemQuantity);
    on<RemoveItemFromSharedCart>(_onRemoveItemFromSharedCart);
    on<AddCollaborator>(_onAddCollaborator);
    on<RemoveCollaborator>(_onRemoveCollaborator);
    on<DeleteSharedCart>(_onDeleteSharedCart);
    on<ClearSharedCartItems>(_onClearSharedCartItems);
  }

  Future<void> _onLoadSharedCarts(
      LoadSharedCarts event, Emitter<SharedCartState> emit) async {
    emit(SharedCartLoading());
    try {
      final snapshot = await _firestore
          .collection('sharedCarts')
          .where('owner', isEqualTo: event.userId)
          .get();

      final collabSnapshot = await _firestore
          .collection('sharedCarts')
          .where('collabs', arrayContains: event.userId)
          .get();

      final allDocs = <String, QueryDocumentSnapshot>{};
      for (var doc in snapshot.docs) {
        allDocs[doc.id] = doc;
      }
      for (var doc in collabSnapshot.docs) {
        allDocs[doc.id] = doc;
      }

      final carts = allDocs.values
          .map((doc) => SharedCart.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      emit(SharedCartsLoaded(carts));
    } catch (e) {
      emit(SharedCartError(e.toString()));
    }
  }

  Future<void> _onCreateSharedCart(
      CreateSharedCart event, Emitter<SharedCartState> emit) async {
    emit(SharedCartLoading());
    try {
      final cart = SharedCart(
        id: '',
        name: event.name,
        owner: event.ownerId,
        collabs: [],
        createdAt: DateTime.now(),
      );

      final docRef = await _firestore.collection('sharedCarts').add(cart.toMap());
      final createdCart = cart.copyWith(id: docRef.id);
      emit(SharedCartCreated(createdCart));
    } catch (e) {
      emit(SharedCartError(e.toString()));
    }
  }

  Future<void> _onLoadSharedCartItems(
      LoadSharedCartItems event, Emitter<SharedCartState> emit) async {
    emit(SharedCartLoading());
    try {
      final snapshot = await _firestore
          .collection('sharedCarts')
          .doc(event.cartId)
          .collection('items')
          .get();

      final items = snapshot.docs
          .map((doc) => SharedCartItem.fromMap({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();

      emit(SharedCartItemsLoaded(cartId: event.cartId, items: items));
    } catch (e) {
      emit(SharedCartError(e.toString()));
    }
  }

  Future<void> _onAddItemToSharedCart(
      AddItemToSharedCart event, Emitter<SharedCartState> emit) async {
    try {
      await _firestore
          .collection('sharedCarts')
          .doc(event.cartId)
          .collection('items')
          .add(event.item.toMap());

      await _firestore.collection('sharedCarts').doc(event.cartId).update({
        'updatedAt': DateTime.now().toIso8601String(),
      });

      emit(SharedCartUpdated());
      add(LoadSharedCartItems(event.cartId));
    } catch (e) {
      emit(SharedCartError(e.toString()));
    }
  }

  Future<void> _onUpdateSharedCartItemQuantity(
      UpdateSharedCartItemQuantity event, Emitter<SharedCartState> emit) async {
    try {
      if (event.quantity <= 0) {
        add(RemoveItemFromSharedCart(cartId: event.cartId, itemId: event.itemId));
        return;
      }

      await _firestore
          .collection('sharedCarts')
          .doc(event.cartId)
          .collection('items')
          .doc(event.itemId)
          .update({'quantity': event.quantity});

      await _firestore.collection('sharedCarts').doc(event.cartId).update({
        'updatedAt': DateTime.now().toIso8601String(),
      });

      emit(SharedCartUpdated());
      add(LoadSharedCartItems(event.cartId));
    } catch (e) {
      emit(SharedCartError(e.toString()));
    }
  }

  Future<void> _onRemoveItemFromSharedCart(
      RemoveItemFromSharedCart event, Emitter<SharedCartState> emit) async {
    try {
      await _firestore
          .collection('sharedCarts')
          .doc(event.cartId)
          .collection('items')
          .doc(event.itemId)
          .delete();

      await _firestore.collection('sharedCarts').doc(event.cartId).update({
        'updatedAt': DateTime.now().toIso8601String(),
      });

      emit(SharedCartUpdated());
      add(LoadSharedCartItems(event.cartId));
    } catch (e) {
      emit(SharedCartError(e.toString()));
    }
  }

  Future<void> _onAddCollaborator(
      AddCollaborator event, Emitter<SharedCartState> emit) async {
    try {
      final cartRef = _firestore.collection('sharedCarts').doc(event.cartId);
      await cartRef.update({
        'collabs': FieldValue.arrayUnion([event.userId]),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      emit(SharedCartUpdated());
    } catch (e) {
      emit(SharedCartError(e.toString()));
    }
  }

  Future<void> _onRemoveCollaborator(
      RemoveCollaborator event, Emitter<SharedCartState> emit) async {
    try {
      final cartRef = _firestore.collection('sharedCarts').doc(event.cartId);
      await cartRef.update({
        'collabs': FieldValue.arrayRemove([event.userId]),
        'updatedAt': DateTime.now().toIso8601String(),
      });

      emit(SharedCartUpdated());
    } catch (e) {
      emit(SharedCartError(e.toString()));
    }
  }

  Future<void> _onDeleteSharedCart(
      DeleteSharedCart event, Emitter<SharedCartState> emit) async {
    emit(SharedCartLoading());
    try {
      // Delete all items first
      final itemsSnapshot = await _firestore
          .collection('sharedCarts')
          .doc(event.cartId)
          .collection('items')
          .get();

      final batch = _firestore.batch();
      for (var doc in itemsSnapshot.docs) {
        batch.delete(doc.reference);
      }
      batch.delete(_firestore.collection('sharedCarts').doc(event.cartId));
      await batch.commit();

      emit(SharedCartDeleted());
    } catch (e) {
      emit(SharedCartError(e.toString()));
    }
  }

  Future<void> _onClearSharedCartItems(
      ClearSharedCartItems event, Emitter<SharedCartState> emit) async {
    try {
      // Get all items in the shared cart
      final itemsSnapshot = await _firestore
          .collection('sharedCarts')
          .doc(event.cartId)
          .collection('items')
          .get();

      // Delete all items in a batch
      final batch = _firestore.batch();
      for (var doc in itemsSnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      // Update the cart's updatedAt timestamp
      await _firestore.collection('sharedCarts').doc(event.cartId).update({
        'updatedAt': DateTime.now().toIso8601String(),
      });

      emit(SharedCartUpdated());
      add(LoadSharedCartItems(event.cartId));
    } catch (e) {
      emit(SharedCartError(e.toString()));
    }
  }
}

