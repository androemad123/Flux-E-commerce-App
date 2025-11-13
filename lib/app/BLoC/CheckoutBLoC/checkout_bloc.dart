import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/order_model.dart';
import '../../../data/repositories/order_repository.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({
    required OrderRepository orderRepository,
    FirebaseAuth? firebaseAuth,
    String? sharedCartId,
  })  : _orderRepository = orderRepository,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(CheckoutState(sharedCartId: sharedCartId)) {
    on<CheckoutStarted>(_onCheckoutStarted);
    on<CheckoutShippingSubmitted>(_onShippingSubmitted);
    on<CheckoutPaymentMethodSelected>(_onPaymentSelected);
    on<CheckoutOrderPlaced>(_onOrderPlaced);
    on<CheckoutReset>(_onCheckoutReset);
  }

  final OrderRepository _orderRepository;
  final FirebaseAuth _firebaseAuth;

  Future<void> _onCheckoutStarted(
    CheckoutStarted event,
    Emitter<CheckoutState> emit,
  ) async {
    final userId = event.userId ?? _firebaseAuth.currentUser?.uid;

    emit(
      state.copyWith(
        status: CheckoutStatus.ready,
        cartItems: event.cartItems,
        userId: userId,
        clearError: true,
      ),
    );
  }

  void _onShippingSubmitted(
    CheckoutShippingSubmitted event,
    Emitter<CheckoutState> emit,
  ) {
    emit(
      state.copyWith(
        status: CheckoutStatus.shippingCompleted,
        address: event.address,
        shippingMethod: event.shippingMethod,
        shippingFee: event.shippingFee,
        clearError: true,
      ),
    );
  }

  void _onPaymentSelected(
    CheckoutPaymentMethodSelected event,
    Emitter<CheckoutState> emit,
  ) {
    emit(
      state.copyWith(
        status: CheckoutStatus.paymentSelected,
        paymentMethod: event.paymentMethod,
        clearError: true,
      ),
    );
  }

  Future<void> _onOrderPlaced(
    CheckoutOrderPlaced event,
    Emitter<CheckoutState> emit,
  ) async {
    if (!state.isReadyToSubmit) {
      emit(
        state.copyWith(
          status: CheckoutStatus.failure,
          errorMessage: 'Checkout information is incomplete.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: CheckoutStatus.submitting,
        clearError: true,
      ),
    );

    try {
      final order = OrderModel.create(
        userId: state.userId ?? _firebaseAuth.currentUser?.uid ?? '',
        items: state.orderItems,
        deliveryAddress: state.address!,
        shippingFee: state.shippingFee,
        paymentMethod: state.paymentMethod!,
        shippingMethod: state.shippingMethod!,
      );

      final orderId = await _orderRepository.createOrder(order);

      emit(
        state.copyWith(
          status: CheckoutStatus.success,
          order: order.copyWith(id: orderId),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CheckoutStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void _onCheckoutReset(
    CheckoutReset event,
    Emitter<CheckoutState> emit,
  ) {
    emit(const CheckoutState());
  }
}
