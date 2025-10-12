import 'package:carousel_slider/carousel_slider.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class imageSlider extends StatefulWidget {
  final List<String> imagePaths;

  const imageSlider({
    super.key,
    required this.imagePaths,
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
        return SizedBox(
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
                      items: widget.imagePaths
                          .map((imgPath) =>
                              Image.asset(imgPath, fit: BoxFit.cover))
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

                    // المؤشرات (Indicators)
                    Positioned(
                      top: 320,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < widget.imagePaths.length; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentImage = i;
                                });
                              },
                              child: Container(
                                width: 18,
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
      },
    );
  }
}
