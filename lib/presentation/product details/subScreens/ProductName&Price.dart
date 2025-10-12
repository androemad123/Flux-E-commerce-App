import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ProductBLoC>().add(LoadProduct(ProductID: widget.productID));
  }

  @override
  Widget build(BuildContext context) {
    // context.read<ProductBLoC>().add(LoadProduct(ProductID: widget.productID));

    return BlocBuilder<ProductBLoC, ProductState>(
      builder: (context, state) {
        if (state.product.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Row(
          children: [
            // product name
            Text(
              state.product[0].ProductName,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontConstants.fontFamily),
            ),
            Spacer(),
            // product price
            Text(" \$ ${state.product[0].ProductPrice}",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontConstants.fontFamily))
          ],
        );
      },
    );
  }
}
