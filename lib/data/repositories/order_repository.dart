import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order_model.dart';
import '../models/order_status.dart';
import '../../firebase_services/firestore_service.dart';

class OrderRepository {
  OrderRepository({
    FirestoreService<OrderModel>? firestoreService,
  }) : _firestore = firestoreService ??
            FirestoreService<OrderModel>(
              collection: 'orders',
              fromJson: (json) => OrderModel.fromJson(json),
              toJson: (order) => order.toJson(),
            );

  final FirestoreService<OrderModel> _firestore;

  Future<String> createOrder(OrderModel order) async {
    return _firestore.create(order);
  }

  Future<List<OrderModel>> fetchOrdersForUser(String userId) async {
    final results = await _firestore.getWhere('userId', userId);
    return results.whereType<OrderModel>().toList()
      ..sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    await _firestore.updateRaw(orderId, {
      'status': status.name,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> addOrderRating({
    required String orderId,
    required double rating,
  }) async {
    await _firestore.updateRaw(orderId, {
      'rating': rating,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> addOrderReview({
    required String orderId,
    required String review,
  }) async {
    await _firestore.updateRaw(orderId, {
      'review': review,
      'updatedAt': Timestamp.now(),
    });
  }
}
