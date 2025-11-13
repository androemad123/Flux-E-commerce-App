import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Productdiscription extends StatefulWidget {
 final String productID;

  Productdiscription({super.key, required this.productID});

  @override
  State<Productdiscription> createState() => _ProductdiscriptionState();
}

class _ProductdiscriptionState extends State<Productdiscription> {
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
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          Product prod = state.product;

          return ExpansionTile(
            shape: Border.all(color: Colors.transparent),
            collapsedShape: Border.all(color: Colors.transparent),
            tilePadding: EdgeInsets.zero,
            title: Text(
              "Description",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: FontConstants.fontFamily,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor),
            ),
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  prod.ProductDescription,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontConstants.fontFamily,
                      color: Theme.of(context).primaryColor),
                ),
              ),
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
