import 'package:carousel_slider/carousel_slider.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class imageSlider extends StatefulWidget {
  final String productID;

  const imageSlider({
    super.key,
    required this.productID,
  });

  @override
  State<imageSlider> createState() => _imageSliderState();
}

class _imageSliderState extends State<imageSlider> {
  int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBLoC, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          List<String> images = state.product.ProductImageURL;

          if (images.isEmpty) {
            return const SizedBox(
              height: 350,
              child: Center(child: Text("No images available")),
            );
          }

          return SizedBox(
            height: 350,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFF4E4DD),
                        radius: 110,
                      ),

                      CarouselSlider(
                        items: images
                            .map(
                              (imgUrl) => ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imgUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                    child: Icon(Icons.broken_image, size: 50));
                              },
                            ),
                          ),
                        )
                            .toList(),
                        options: CarouselOptions(
                          height: 350,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentImage = index;
                            });
                          },
                        ),
                      ),

                      // Indicators
                      Positioned(
                        top: 320,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < images.length; i++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _currentImage = i;
                                  });
                                },
                                child: Container(
                                  width: 18,
                                  margin: const EdgeInsets.symmetric(horizontal: 3),
                                  child: Icon(
                                    _currentImage == i
                                        ? Icons.circle
                                        : Icons.circle_outlined,
                                    size: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
              child: Text(
                "Something went wrong!!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ));
        }
      },
    );
  }
}
