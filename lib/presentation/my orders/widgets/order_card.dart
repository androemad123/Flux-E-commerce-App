import 'package:flutter/material.dart';
import 'package:depi_graduation/data/models/order_details.dart';
import 'package:depi_graduation/data/models/order_status.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:depi_graduation/generated/l10n.dart'; // intl generated file

class OrderCard extends StatelessWidget {
  final OrderDetails order;
  final VoidCallback onDetailsPressed;

  const OrderCard({
    Key? key,
    required this.order,
    required this.onDetailsPressed,
  }) : super(key: key);

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.canceled:
        return Colors.red;
    }
  }

  String _getLocalizedStatus(BuildContext context, OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return S.of(context).pending;
      case OrderStatus.delivered:
        return S.of(context).delivered;
      case OrderStatus.canceled:
        return S.of(context).cancelled;
    }
  }

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
                  "${order.date.day}/${order.date.month}/${order.date.year}",
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
                    text: order.trackingNumber,
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
                  "${S.of(context).quantity}: ${order.quantity}",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getLocalizedStatus(context, order.status),
                  style: boldStyle(
                    fontSize: 14,
                    color: _getStatusColor(order.status),
                  ),
                ),
                OutlinedButton(
                  onPressed: onDetailsPressed,
                  child: Text(
                    S.of(context).details,
                    style: regularStyle(
                      fontSize: 14,
                      color: ColorManager.primaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
