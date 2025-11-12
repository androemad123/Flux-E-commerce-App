import 'package:equatable/equatable.dart';

import '../../../data/models/order_model.dart';

enum OrdersLoadStatus { initial, loading, success, failure }

enum OrderOperationStatus { idle, submitting, success, failure }

class OrdersState extends Equatable {
  const OrdersState({
    this.loadStatus = OrdersLoadStatus.initial,
    this.operationStatus = OrderOperationStatus.idle,
    this.orders = const [],
    this.errorMessage,
    this.lastOrderId,
  });

  final OrdersLoadStatus loadStatus;
  final OrderOperationStatus operationStatus;
  final List<OrderModel> orders;
  final String? errorMessage;
  final String? lastOrderId;

  OrdersState copyWith({
    OrdersLoadStatus? loadStatus,
    OrderOperationStatus? operationStatus,
    List<OrderModel>? orders,
    String? errorMessage,
    String? lastOrderId,
  }) {
    return OrdersState(
      loadStatus: loadStatus ?? this.loadStatus,
      operationStatus: operationStatus ?? this.operationStatus,
      orders: orders ?? this.orders,
      errorMessage: errorMessage,
      lastOrderId: lastOrderId ?? this.lastOrderId,
    );
  }

  bool get isLoading => loadStatus == OrdersLoadStatus.loading;

  @override
  List<Object?> get props => [
        loadStatus,
        operationStatus,
        orders,
        errorMessage,
        lastOrderId,
      ];
}
