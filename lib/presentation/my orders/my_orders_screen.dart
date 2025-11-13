import 'package:depi_graduation/app/BLoC/OrderBLoC/orders_bloc.dart';
import 'package:depi_graduation/app/BLoC/OrderBLoC/orders_event.dart';
import 'package:depi_graduation/app/BLoC/OrderBLoC/orders_state.dart';
import 'package:depi_graduation/data/models/order_model.dart';
import 'package:depi_graduation/data/models/order_status.dart';
import 'package:depi_graduation/presentation/my%20orders/widgets/order_card.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_graduation/generated/l10n.dart';

import 'order_details_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  OrderStatus _selectedStatus = OrderStatus.pending;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    context.read<OrdersBloc>().add(OrdersRequested(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.myOrdersTitle,
          style: boldStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFilterButton(s.pending, OrderStatus.pending),
                    _buildFilterButton(s.processing, OrderStatus.processing),
                    _buildFilterButton(s.shipped, OrderStatus.shipped),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildFilterButton(s.delivered, OrderStatus.delivered),
                    _buildFilterButton(s.cancelled, OrderStatus.cancelled),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) {
                if (state.loadStatus == OrdersLoadStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.loadStatus == OrdersLoadStatus.failure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage ?? 'Failed to load orders',
                          style: regularStyle(
                            fontSize: 14,
                            color: ColorManager.lightGrayLight,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _loadOrders,
                          child: const Text('Retry'),
                        )
                      ],
                    ),
                  );
                }

                final filteredOrders = _filterOrders(state.orders);

                if (filteredOrders.isEmpty) {
                  return Center(
                    child: Text(
                      s.noOrders(_selectedStatus.name),
                      style: regularStyle(
                        fontSize: 14,
                        color: ColorManager.lightGrayLight,
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => _loadOrders(),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return OrderCard(
                        order: order,
                        onDetailsPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailsScreen(
                                order: order,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<OrderModel> _filterOrders(List<OrderModel> orders) {
    return orders.where((order) => order.status == _selectedStatus).toList();
  }

  Widget _buildFilterButton(String text, OrderStatus status) {
    final bool isSelected = _selectedStatus == status;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = status;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.darkGrayLight : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: boldStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
