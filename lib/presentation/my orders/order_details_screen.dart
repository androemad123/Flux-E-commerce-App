import 'package:depi_graduation/presentation/rate%20product/rate_product_screen.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:depi_graduation/data/models/order_details.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/data/models/order_status.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:depi_graduation/generated/l10n.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderDetails order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  String _getStatusMessage(BuildContext context, OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return S.of(context).delivered;
      case OrderStatus.pending:
        return S.of(context).pending;
      case OrderStatus.canceled:
        return S.of(context).cancelled;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),
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
            /// Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getStatusColor(order.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_shipping,
                      color: _getStatusColor(order.status), size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "${S.of(context).yourOrderIs} ${_getStatusMessage(context, order.status)}",
                      style: boldStyle(
                        fontSize: 16,
                        color: _getStatusColor(order.status),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            /// Order Info
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
                      order.trackingNumber,
                    ),
                    _buildInfoRow(
                      context,
                      S.of(context).deliveryAddress,
                      order.address,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// Products
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (Product product in order.products)
                      _buildProductRow(product),
                    const Divider(),
                    _buildInfoRow(context, S.of(context).subtotal,
                        "\$${order.total.toStringAsFixed(2)}"),
                    _buildInfoRow(context, S.of(context).shipping, "\$0.00"),
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
            const SizedBox(height: 20),

            /// Buttons
            if (order.status == OrderStatus.delivered) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppTextButton(
                    color: Colors.grey,
                    width: 150,
                    text: S.of(context).returnHome,
                    textColor: Colors.black54,
                    onPressed: () {
                      // Navigate home
                      Navigator.pop(context);
                    },
                  ),
                  AppTextButton(text: S.of(context).rate,width: 100, onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>RateProductScreen()
                      ),
                    );
                  },)
                ],
              ),
            ] else ...[
              Center(
                  child: AppTextButton(
                    width: 200,
                    fontSize: 18,
                text: S.of(context).continueShopping,
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value,
      {bool isBold = false}) {
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
          Text(
            value,
            style: isBold
                ? boldStyle(fontSize: 14, color: ColorManager.darkGrayLight)
                : regularStyle(fontSize: 14, color: ColorManager.darkGrayLight),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(product.ProductName,
                style: boldStyle(fontSize: 14, color: Colors.black)),
          ),
          Text("x${product.ProductQuantity}",
              style: regularStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(width: 12),
          Text("\$${(product.ProductPrice * product.ProductQuantity).toStringAsFixed(2)}",
              style: boldStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }
}
