import 'package:depi_graduation/app/BLoC/CartBLoC/cart_bloc.dart';
import 'package:depi_graduation/app/BLoC/CartBLoC/cart_event.dart';
import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_bloc.dart';
import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_event.dart';
import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_state.dart';
import 'package:depi_graduation/app/BLoC/OrderBLoC/orders_bloc.dart';
import 'package:depi_graduation/app/BLoC/OrderBLoC/orders_event.dart';
import 'package:depi_graduation/app/BLoC/SharedCartBLoC/shared_cart_bloc.dart';
import 'package:depi_graduation/app/BLoC/SharedCartBLoC/shared_cart_event.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';
import 'package:depi_graduation/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinalCheckoutScreen extends StatelessWidget {
  const FinalCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state.status == CheckoutStatus.success) {
          // Clear regular cart
          context.read<CartBloc>().add(const CartCleared());
          
          // Clear shared cart if checkout was from a shared cart
          if (state.sharedCartId != null) {
            context.read<SharedCartBloc>().add(
              ClearSharedCartItems(state.sharedCartId!),
            );
          }
          
          // Reload orders
          final userId = state.userId;
          if (userId != null && userId.isNotEmpty) {
            context
                .read<OrdersBloc>()
                .add(OrdersRequested(userId: userId));
          }
        }
      },
      builder: (context, state) {
        if (state.status == CheckoutStatus.success && state.order != null) {
          return _buildSuccessContent(context, theme, state);
        }

        final isLoading = state.status == CheckoutStatus.submitting;
        final hasError = state.status == CheckoutStatus.failure;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review & Confirm',
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.primary,
                    fontSize: FontSize.s26,
                  ),
                ),
                SizedBox(height: 20.h),
                if (hasError && state.errorMessage != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      state.errorMessage!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                _SummarySection(state: state),
                AppTextButton(
                  onPressed:
                      isLoading ? null : () => context.read<CheckoutBloc>().add(const CheckoutOrderPlaced()),
                  text: isLoading ? 'Placing Order...' : 'Place Order',
                  width: double.infinity,
                  color: Colors.black,
                ),
                SizedBox(height: 10.h),
                if (isLoading) const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuccessContent(
      BuildContext context, ThemeData theme, CheckoutState state) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          Image.asset(
            'assets/images/Vector.png',
            color: Colors.black,
            width: 120,
          ),
          SizedBox(height: 30.h),
          Text(
            'Order Confirmed!',
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.primary,
              fontSize: FontSize.s24,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Order ID: ${state.order!.id}',
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 16.h),
          Text(
            'You can track your order in the "My Orders" section.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 40.h),
          AppTextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.appInit,
                (route) => false,
              );
            },
            text: 'Continue Shopping',
            width: double.infinity,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({required this.state});

  final CheckoutState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: theme.textTheme.titleMedium?.copyWith(
                fontFamily: FontConstants.fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...state.cartItems.map(
              (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  item.product.ProductName,
                  style: theme.textTheme.bodyLarge,
                ),
                subtitle: Text(
                  'x${item.quantity}'
                  '${item.selectedSize != null ? ' • Size: ${item.selectedSize}' : ''}'
                  '${item.selectedColor != null ? ' • Color: ${item.selectedColor}' : ''}',
                ),
                trailing: Text(
                  '\$${item.subtotal.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(),
            _buildRow(theme, 'Subtotal', state.subtotal),
            _buildRow(theme, 'Shipping', state.shippingFee),
            const Divider(),
            _buildRow(
              theme,
              'Total',
              state.total,
              isBold: true,
            ),
            const SizedBox(height: 16),
            if (state.address != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping to',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    state.address!.fullName,
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    '${state.address!.street}, ${state.address!.city}, ${state.address!.state}',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    '${state.address!.country}, ${state.address!.zipCode}',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    state.address!.phoneNumber,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            const SizedBox(height: 12),
            if (state.paymentMethod != null)
              Text(
                'Payment method: ${state.paymentMethod}',
                style: theme.textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    ThemeData theme,
    String label,
    double value, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: (isBold
                    ? theme.textTheme.titleMedium
                    : theme.textTheme.bodyMedium)
                ?.copyWith(fontWeight: isBold ? FontWeight.bold : null),
          ),
        ],
      ),
    );
  }
}
