import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/order_model.dart';
import '../../../data/models/order_status.dart';
import '../../../data/repositories/order_repository.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({
    required OrderRepository orderRepository,
  })  : _orderRepository = orderRepository,
        super(const OrdersState()) {
    on<OrdersRequested>(_onOrdersRequested);
    on<OrderSubmitted>(_onOrderSubmitted);
    on<OrderStatusUpdated>(_onOrderStatusUpdated);
    on<OrderRated>(_onOrderRated);
    on<OrderReviewed>(_onOrderReviewed);
  }

  final OrderRepository _orderRepository;

  Future<void> _onOrdersRequested(
    OrdersRequested event,
    Emitter<OrdersState> emit,
  ) async {
    emit(
      state.copyWith(
        loadStatus: OrdersLoadStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      final orders = await _orderRepository.fetchOrdersForUser(event.userId);
      emit(
        state.copyWith(
          loadStatus: OrdersLoadStatus.success,
          orders: orders,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          loadStatus: OrdersLoadStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onOrderSubmitted(
    OrderSubmitted event,
    Emitter<OrdersState> emit,
  ) async {
    emit(
      state.copyWith(
        operationStatus: OrderOperationStatus.submitting,
        errorMessage: null,
      ),
    );

    try {
      final orderId = await _orderRepository.createOrder(event.order);
      final updatedOrders = [
        event.order.copyWith(id: orderId),
        ...state.orders,
      ];

      emit(
        state.copyWith(
          operationStatus: OrderOperationStatus.success,
          orders: updatedOrders,
          lastOrderId: orderId,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          operationStatus: OrderOperationStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onOrderStatusUpdated(
    OrderStatusUpdated event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      await _orderRepository.updateOrderStatus(
        orderId: event.orderId,
        status: event.status,
      );

      final updatedOrders = state.orders.map((order) {
        if (order.id == event.orderId) {
          return order.copyWith(
            status: event.status,
            updatedAt: DateTime.now(),
          );
        }
        return order;
      }).toList();

      emit(
        state.copyWith(
          orders: updatedOrders,
          operationStatus: OrderOperationStatus.success,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          operationStatus: OrderOperationStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onOrderRated(
    OrderRated event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      await _orderRepository.addOrderRating(
        orderId: event.orderId,
        rating: event.rating,
      );

      final updatedOrders = state.orders.map((order) {
        if (order.id == event.orderId) {
          return order.copyWith(
            rating: event.rating,
            updatedAt: DateTime.now(),
          );
        }
        return order;
      }).toList();

      emit(
        state.copyWith(
          orders: updatedOrders,
          operationStatus: OrderOperationStatus.success,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          operationStatus: OrderOperationStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onOrderReviewed(
    OrderReviewed event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      await _orderRepository.addOrderReview(
        orderId: event.orderId,
        review: event.review,
      );

      final updatedOrders = state.orders.map((order) {
        if (order.id == event.orderId) {
          return order.copyWith(
            review: event.review,
            updatedAt: DateTime.now(),
          );
        }
        return order;
      }).toList();

      emit(
        state.copyWith(
          orders: updatedOrders,
          operationStatus: OrderOperationStatus.success,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          operationStatus: OrderOperationStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
