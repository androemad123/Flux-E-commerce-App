import 'package:depi_graduation/data/models/order_item.dart' as order_item;
import 'package:depi_graduation/data/models/order_model.dart';
import 'package:depi_graduation/data/models/order_status.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:depi_graduation/generated/l10n.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  final OrderModel order;

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

  String _statusLabel(BuildContext context, OrderStatus status) {
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
      order.items.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.status);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${S.of(context).myOrdersTitle} #${order.id}",
          style: boldStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_shipping, color: statusColor, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "${S.of(context).yourOrderIs} ${_statusLabel(context, order.status)}",
                      style: boldStyle(
                        fontSize: 16,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow(
                      context,
                      S.of(context).orderNumber,
                      "#${order.id}",
                    ),
                    _buildInfoRow(
                      context,
                      S.of(context).trackingNumber,
                      order.trackingNumber ?? '—',
                    ),
                    _buildInfoRow(
                      context,
                      'Placed on',
                      "${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}",
                    ),
                    _buildInfoRow(
                      context,
                      'Payment',
                      order.paymentMethod,
                    ),
                    _buildInfoRow(
                      context,
                      'Shipping via',
                      order.shippingMethod,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shipping to',
                      style: boldStyle(
                        fontSize: 16,
                        color: ColorManager.darkGrayLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(order.deliveryAddress.fullName),
                    Text(order.deliveryAddress.street),
                    Text(
                      "${order.deliveryAddress.city}, ${order.deliveryAddress.state}",
                    ),
                    Text(
                      "${order.deliveryAddress.country}, ${order.deliveryAddress.zipCode}",
                    ),
                    Text(order.deliveryAddress.phoneNumber),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (final item in order.items) _buildProductRow(item),
                    const Divider(),
                    _buildInfoRow(
                      context,
                      S.of(context).quantity,
                      _totalQuantity.toString(),
                    ),
                    _buildInfoRow(
                      context,
                      S.of(context).subtotal,
                      "\$${order.subtotal.toStringAsFixed(2)}",
                    ),
                    _buildInfoRow(
                      context,
                      S.of(context).shipping,
                      "\$${order.shippingFee.toStringAsFixed(2)}",
                    ),
                    const Divider(),
                    _buildInfoRow(
                      context,
                      S.of(context).total,
                      "\$${order.total.toStringAsFixed(2)}",
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            AppTextButton(
              width: double.infinity,
              color: Colors.black,
              text: S.of(context).continueShopping,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
  }) {
    final style = isBold
        ? boldStyle(fontSize: 14, color: ColorManager.darkGrayLight)
        : regularStyle(fontSize: 14, color: ColorManager.darkGrayLight);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: regularStyle(
              fontSize: 14,
              color: ColorManager.lightGrayLight,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: style,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(order_item.OrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: boldStyle(fontSize: 14, color: Colors.black),
                ),
                if (item.selectedSize != null || item.selectedColor != null)
                  Text(
                    [
                      if (item.selectedSize != null)
                        'Size: ${item.selectedSize}',
                      if (item.selectedColor != null)
                        'Color: ${item.selectedColor}',
                    ].join(' • '),
                    style: regularStyle(
                      fontSize: 12,
                      color: ColorManager.lightGrayLight,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            "x${item.quantity}",
            style: regularStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Text(
            "\$${item.lineTotal.toStringAsFixed(2)}",
            style: boldStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
