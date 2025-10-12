import 'package:depi_graduation/data/models/order_details.dart';
import 'package:depi_graduation/presentation/my%20orders/widgets/order_card.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:depi_graduation/generated/l10n.dart';
import 'package:provider/provider.dart';

import '../../app/provider/language_provider.dart';
import '../../data/models/order_status.dart';
import '../widgets/app_text_button.dart';
import 'order_details_screen.dart'; // Import your generated localization

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  OrderStatus _selectedStatus = OrderStatus.pending;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    final s = S.of(context);

    final filteredOrders = OrderDetails.mockOrders
        .where((order) => order.status == _selectedStatus)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          s.myOrdersTitle,
          style: boldStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          )
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterButton(s.pending, OrderStatus.pending),
                _buildFilterButton(s.delivered, OrderStatus.delivered),
                _buildFilterButton(s.cancelled, OrderStatus.canceled),
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: filteredOrders.isEmpty
                ? Center(
              child: Text(
                s.noOrders(_selectedStatus.name),
                style: regularStyle(
                  fontSize: 14,
                  color: ColorManager.lightGrayLight,
                ),
              ),
            )
                : ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                return OrderCard(
                  order: filteredOrders[index],
                  onDetailsPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(
                          order: filteredOrders[index],
                        ),
                      ),
                    );
                  },
                );
              },
            )



          ),
          AppTextButton(
           text: "Ar",
            onPressed: () {
              languageProvider.setLocale(const Locale('ar'));

            },
          ),
          SizedBox(height: 100,),

          AppTextButton(
            text: "EN",
            onPressed: () {
              languageProvider.setLocale(const Locale('en'));
            },
          ),
          SizedBox(height: 100,),
        ],
      ),
    );
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.darkGrayLight : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: boldStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
