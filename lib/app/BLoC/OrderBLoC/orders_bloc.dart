import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'orders_event.dart';
import 'orders_state.dart';
import '../../../data/models/order_model.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  OrdersBloc() : super(OrdersInitial()) {
    on<LoadOrders>((event, emit) async {
      emit(OrdersLoading());
      try {
        final snapshot = await _firestore
            .collection('orders')
            .where('userId', isEqualTo: event.userId)
            .get();

        final orders = snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
            .toList();

        emit(OrdersLoaded(orders));
      } catch (e) {
        emit(OrdersError(e.toString()));
      }
    });

    on<AddOrder>((event, emit) async {
      try {
        await _firestore.collection('orders').add(event.order.toMap());
        emit(OrderAdded());
      } catch (e) {
        emit(OrdersError(e.toString()));
      }
    });

    on<UpdateOrderStatus>((event, emit) async {
      try {
        await _firestore
            .collection('orders')
            .doc(event.orderId)
            .update({'status': event.newStatus});
        emit(OrderUpdated());
      } catch (e) {
        emit(OrdersError(e.toString()));
      }
    });

    on<AddOrderRating>((event, emit) async {
      try {
        await _firestore
            .collection('orders')
            .doc(event.orderId)
            .update({'rating': event.rating});
        emit(RatingAdded());
      } catch (e) {
        emit(OrdersError(e.toString()));
      }
    });

    on<AddOrderTextReview>((event, emit) async {
      try {
        await _firestore
            .collection('orders')
            .doc(event.orderId)
            .update({'review': event.review});
        emit(ReviewAdded());
      } catch (e) {
        emit(OrdersError(e.toString()));
      }
    });

    on<LoadRatedOrders>((event, emit) async {
      emit(OrdersLoading());
      try {
        final snapshot = await _firestore
            .collection('orders')
            .where('userId', isEqualTo: event.userId)
            .where('rating', isGreaterThan: 0)
            .get();

        final ratedOrders = snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
            .toList();

        emit(RatedOrdersLoaded(ratedOrders));
      } catch (e) {
        emit(OrdersError(e.toString()));
      }
    });

    on<LoadReviewedOrders>((event, emit) async {
      emit(OrdersLoading());
      try {
        final snapshot = await _firestore
            .collection('orders')
            .where('userId', isEqualTo: event.userId)
            .where('review', isNotEqualTo: null)
            .get();

        final reviewedOrders = snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
            .toList();

        emit(ReviewedOrdersLoaded(reviewedOrders));
      } catch (e) {
        emit(OrdersError(e.toString()));
      }
    });
  }
}
