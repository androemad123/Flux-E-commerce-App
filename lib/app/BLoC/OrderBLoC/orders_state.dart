import '../../../data/models/order_model.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderModel> orders;
  OrdersLoaded(this.orders);
}

class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}

class OrderAdded extends OrdersState {}

class OrderUpdated extends OrdersState {}

class RatingAdded extends OrdersState {}

class ReviewAdded extends OrdersState {}

class RatedOrdersLoaded extends OrdersState {
  final List<OrderModel> ratedOrders;
  RatedOrdersLoaded(this.ratedOrders);
}

class ReviewedOrdersLoaded extends OrdersState {
  final List<OrderModel> reviewedOrders;
  ReviewedOrdersLoaded(this.reviewedOrders);
}
