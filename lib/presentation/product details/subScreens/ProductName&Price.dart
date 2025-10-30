import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Product_Name_Price extends StatefulWidget {
  String productID;

  Product_Name_Price({
    super.key,
    required this.productID,
  });

  @override
  State<Product_Name_Price> createState() => _Product_Name_PriceState();
}

class _Product_Name_PriceState extends State<Product_Name_Price> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBLoC, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          Product prod = state.product;
          return Row(
            children: [
              // product name
              Text(
                prod.ProductName,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontConstants.fontFamily),
              ),
              Spacer(),
              // product price
              Text(" \$ ${prod.ProductPrice}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontConstants.fontFamily))
            ],
          );
        } else {
          return Center(
              child: Text(
            "Something went wrong!!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ));
        }
      },
    );
  }
}
