import 'package:depi_graduation/app/BLoC/CartBLoC/cart_bloc.dart';
import 'package:depi_graduation/app/BLoC/CartBLoC/cart_event.dart';
import 'package:depi_graduation/app/BLoC/CartBLoC/cart_state.dart';
import 'package:depi_graduation/data/models/cart_item.dart';
import 'package:depi_graduation/presentation/resources/color_from_string_helper.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCartScreen extends StatelessWidget {
  const ProductsCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final isEmpty = state.items.isEmpty;
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                floating: true,
                title: Text(
                  "Your Cart",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              if (isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: FontConstants.fontFamily,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = state.items[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _CartItemCard(item: item),
                        );
                      },
                      childCount: state.items.length,
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: isEmpty
                  ? null
                  : () {
                      Navigator.pushNamed(context, Routes.checkoutRoute);
                    },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Proceed to checkout",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: FontConstants.fontFamily,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "Total: ${state.subtotal.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final Color? selectedColor = item.selectedColor != null
        ? colorFromString(item.selectedColor!)
        : null;

    final attributeTextParts = <String>[];
    if (item.selectedSize != null && item.selectedSize!.isNotEmpty) {
      attributeTextParts.add('Size: ${item.selectedSize}');
    }
    if (item.selectedColor != null && item.selectedColor!.isNotEmpty) {
      attributeTextParts.add('Color: ${item.selectedColor}');
    }
    final attributeText = attributeTextParts.join(' • ');

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.product.getDisplayImage(),
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.ProductName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.fontFamily,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.product.ProductDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      if (attributeText.isNotEmpty || selectedColor != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              if (selectedColor != null)
                                Container(
                                  width: 14,
                                  height: 14,
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    color: selectedColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                              if (attributeText.isNotEmpty)
                                Expanded(
                                  child: Text(
                                    attributeText,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<CartBloc>().add(
                          CartItemRemoved(
                            productId: item.product.ProductID,
                            selectedColor: item.selectedColor,
                            selectedSize: item.selectedSize,
                          ),
                        );
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.grey.shade500,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item.subtotal.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(
                                CartItemQuantityUpdated(
                                  productId: item.product.ProductID,
                                  selectedColor: item.selectedColor,
                                  selectedSize: item.selectedSize,
                                  quantity: item.quantity - 1,
                                ),
                              );
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        item.quantity.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontConstants.fontFamily,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(
                                CartItemQuantityUpdated(
                                  productId: item.product.ProductID,
                                  selectedColor: item.selectedColor,
                                  selectedSize: item.selectedSize,
                                  quantity: item.quantity + 1,
                                ),
                              );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
