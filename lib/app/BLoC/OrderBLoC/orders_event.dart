import '../../../data/models/order_model.dart';
abstract class OrdersEvent {}

class LoadOrders extends OrdersEvent {
  final String userId;
  LoadOrders(this.userId);
}

class AddOrder extends OrdersEvent {
  final OrderModel order;
  AddOrder(this.order);
}

class UpdateOrderStatus extends OrdersEvent {
  final String orderId;
  final String newStatus;
  UpdateOrderStatus(this.orderId, this.newStatus);
}

class AddOrderRating extends OrdersEvent {
  final String orderId;
  final double rating;
  AddOrderRating(this.orderId, this.rating);
}

class AddOrderTextReview extends OrdersEvent {
  final String orderId;
  final String review;
  AddOrderTextReview(this.orderId, this.review);
}

class LoadRatedOrders extends OrdersEvent {
  final String userId;
  LoadRatedOrders(this.userId);
}

class LoadReviewedOrders extends OrdersEvent {
  final String userId;
  LoadReviewedOrders(this.userId);
}
