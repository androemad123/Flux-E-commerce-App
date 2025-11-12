import 'package:equatable/equatable.dart';

import '../../../data/models/order_model.dart';
import '../../../data/models/order_status.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

class OrdersRequested extends OrdersEvent {
  const OrdersRequested({required this.userId});

  final String userId;

  @override
  List<Object?> get props => [userId];
}

class OrderSubmitted extends OrdersEvent {
  const OrderSubmitted({required this.order});

  final OrderModel order;

  @override
  List<Object?> get props => [order];
}

class OrderStatusUpdated extends OrdersEvent {
  const OrderStatusUpdated({
    required this.orderId,
    required this.status,
  });

  final String orderId;
  final OrderStatus status;

  @override
  List<Object?> get props => [orderId, status];
}

class OrderRated extends OrdersEvent {
  const OrderRated({
    required this.orderId,
    required this.rating,
  });

  final String orderId;
  final double rating;

  @override
  List<Object?> get props => [orderId, rating];
}

class OrderReviewed extends OrdersEvent {
  const OrderReviewed({
    required this.orderId,
    required this.review,
  });

  final String orderId;
  final String review;

  @override
  List<Object?> get props => [orderId, review];
}
