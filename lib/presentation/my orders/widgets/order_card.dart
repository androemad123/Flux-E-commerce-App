import 'package:depi_graduation/presentation/rate%20product/rate_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:depi_graduation/data/models/order_model.dart';
import 'package:depi_graduation/data/models/order_status.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:depi_graduation/generated/l10n.dart'; // intl generated file

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onDetailsPressed;

  const OrderCard({
    Key? key,
    required this.order,
    required this.onDetailsPressed,
  }) : super(key: key);

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
      case OrderStatus.processing:
        return Colors.orangeAccent;
      case OrderStatus.shipped:
        return Colors.blueAccent;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.redAccent;
    }
  }

  String _getLocalizedStatus(BuildContext context, OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return S.of(context).pending;
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return S.of(context).delivered;
      case OrderStatus.cancelled:
        return S.of(context).cancelled;
    }
  }

  int get _totalQuantity =>
      order.items.fold(0, (total, item) => total + item.quantity);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Order ID and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${S.of(context).myOrdersTitle} #${order.id}",
                  style: boldStyle(
                    fontSize: 16,
                    color: ColorManager.darkGrayLight,
                  ),
                ),
                Text(
                  "${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}",
                  style: regularStyle(
                    fontSize: 14,
                    color: ColorManager.lightGrayLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Tracking number
            Text.rich(
              TextSpan(
                text: "${S.of(context).trackingNumber}: ",
                style: regularStyle(
                  fontSize: 14,
                  color: ColorManager.lightGrayLight,
                ),
                children: [
                  TextSpan(
                    text: order.trackingNumber ?? '—',
                    style: boldStyle(
                      fontSize: 14,
                      color: ColorManager.darkGrayLight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            /// Quantity and Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${S.of(context).quantity}: ${_totalQuantity}",
                  style: regularStyle(
                    fontSize: 14,
                    color: ColorManager.lightGrayLight,
                  ),
                ),
                Text(
                  "${S.of(context).subtotal}: \$${order.total.toStringAsFixed(2)}",
                  style: boldStyle(
                    fontSize: 16,
                    color: ColorManager.darkGrayLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Status and Details Button
            /// Status, Details, and Rate Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Order status text
                Text(
                  _getLocalizedStatus(context, order.status),
                  style: boldStyle(
                    fontSize: 14,
                    color: _getStatusColor(order.status),
                  ),
                ),
                /// Action buttons (Details + Rate)
                Row(
                  children: [
                    // Details button (always shown)
                    OutlinedButton(
                      onPressed: onDetailsPressed,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: ColorManager.primaryLight),
                      ),
                      child: Text(
                        S.of(context).details,
                        style: regularStyle(
                          fontSize: 14,
                          color: ColorManager.primaryLight,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
            if (order.status == OrderStatus.delivered)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in order.items)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: regularStyle(fontSize: 13, color: ColorManager.primaryLight),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RateProductScreen(
                                      productId: item.productId,
                                      orderId: order.id,
                                    ),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: ColorManager.primaryLight),
                              ),
                              child: Text(
                                S.of(context).rate,
                                style: regularStyle(
                                  fontSize: 14,
                                  color: ColorManager.primaryLight,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
