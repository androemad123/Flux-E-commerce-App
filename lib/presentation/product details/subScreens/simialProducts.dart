import 'package:depi_graduation/presentation/product%20details/product_details_screen.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';

class simialProducts extends StatefulWidget {
  List<String> productNames;
  List<String> similarProductPrices;
  String? productId;
  simialProducts(
      {super.key,
      this.productId,
      required this.productNames,
      required this.similarProductPrices});

  @override
  State<simialProducts> createState() => _simialProductsState();
}

class _simialProductsState extends State<simialProducts> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      shape: Border.all(color: Colors.transparent),
      collapsedShape: Border.all(color: Colors.transparent),
      title: Text(
        "Similar Product",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: FontConstants.fontFamily,
            fontSize: 16,
            color: Theme.of(context).primaryColor),
      ),
      children: [
        // similar products
        Container(
          height: 200,
          // similar product info

          child: ListView.separated(
            //  shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 15,
              );
            },
            itemCount: 5,
            itemBuilder: (context, index) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      shadowColor: Colors.transparent,
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                                productId: widget.productId ?? "",
                              )),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          width: 126,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/images/iconDark.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),

                      //similar product name

                      Text(
                        "${widget.productNames[index]}",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontConstants.fontFamily,
                            color: Theme.of(context).primaryColor),
                      ),

                      //similar product price
                      Text(
                        "\$ ${widget.similarProductPrices[index]}",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: FontConstants.fontFamily,
                            fontWeight: FontWeightManager.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}
