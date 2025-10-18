import 'package:depi_graduation/presentation/product%20details/subScreens/ProductName&Price.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/imageSlider.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/productDetailsAppBar.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/productDiscription.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/productReviews.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/product_color_size.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/simialProducts.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/starsRating.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int rate = 0;
  List<Color> clrs = [Color(0xFFF4E4DD), Colors.black, Colors.red];
  List<String> txt = ["S", "M", "L"];
  String ratingNumber = "4.9";
  List<int> nums = [5, 4, 3, 2, 1];
  List<double> percentages = [.80, .12, .5, .3, 0];
  List<String> productNames = [
    "Rise Crop Hoodie",
    "Gym Crop Top",
    "Gym Crop Top",
    "Gym Crop Top",
    "Gym Crop Top",
  ];
  List<String> similarProductPrices = [
    "40.00",
    "35.99",
    "100.00",
    "85.5",
    "20.00"
  ];

  List<String> getImagesList() {
    if (_selectedColor == 0) {
      if (_selectedSize == 0) return firstColor_Small;
      if (_selectedSize == 1) return firstColor_Medium;
      if (_selectedSize == 2) return firstColor_Large;
    } else if (_selectedColor == 1) {
      if (_selectedSize == 0) return secondColor_Small;
      if (_selectedSize == 1) return secondColor_Medium;
      if (_selectedSize == 2) return secondColor_Large;
    } else if (_selectedColor == 2) {
      if (_selectedSize == 0) return thirdColor_Small;
      if (_selectedSize == 1) return thirdColor_Medium;
      if (_selectedSize == 2) return thirdColor_Large;
    }

    return firstColor_Small;
  }

  int numOfReviews = 47;
  int numOfRatings = 83;
  String productDescription = "Sportswear is no longer under culture, "
      "it is no longer indie or cobbled together as it once was. "
      "Sport is fashion today. The top is oversized in fit and style, may need to size down.";
  bool isFavourite = false;
  String productName = "Sportwear Set";
  String productPrice = "80.00";
  int _currentImage = 0;
  List<bool> _currentColor = [false, false, false];
  List<bool> _CurrentSize = [false, false, false];

  int _selectedColor = 0;
  int _selectedSize = 0;

  final List<String> firstColor_Small = [
    "assets/images/1stOnboardingPic.jpg",
    "assets/images/2ndOnboardingPic.jpg",
    "assets/images/3rdOnboardingPic.jpg",
  ];
  final List<String> firstColor_Medium = [
    "assets/images/3rdOnboardingPic.jpg",
    "assets/images/iconDark.png",
    "assets/images/iconDark.png",
  ];
  final List<String> firstColor_Large = [
    "assets/images/1stOnboardingPic.jpg",
    "assets/images/iconlight.png",
    "assets/images/iconlight.png",
  ];
  final List<String> secondColor_Small = [
    "assets/images/1stOnboardingPic.jpg",
    "assets/images/2ndOnboardingPic.jpg",
    "assets/images/3rdOnboardingPic.jpg",
  ];
  final List<String> secondColor_Medium = [
    "assets/images/1stOnboardingPic.jpg",
    "assets/images/2ndOnboardingPic.jpg",
    "assets/images/3rdOnboardingPic.jpg",
  ];
  final List<String> secondColor_Large = [
    "assets/images/1stOnboardingPic.jpg",
    "assets/images/2ndOnboardingPic.jpg",
    "assets/images/3rdOnboardingPic.jpg",
  ];
  final List<String> thirdColor_Small = [
    "assets/images/1stOnboardingPic.jpg",
    "assets/images/2ndOnboardingPic.jpg",
    "assets/images/3rdOnboardingPic.jpg",
  ];
  final List<String> thirdColor_Medium = [
    "assets/images/1stOnboardingPic.jpg",
    "assets/images/2ndOnboardingPic.jpg",
    "assets/images/3rdOnboardingPic.jpg",
  ];
  final List<String> thirdColor_Large = [
    "assets/images/1stOnboardingPic.jpg",
    "assets/images/2ndOnboardingPic.jpg",
    "assets/images/3rdOnboardingPic.jpg",
  ];

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: CustomScrollView(
        slivers: [
          //Screen AppBar
          sliverAppbar(
            isFavourite: isFavourite,
            onBack: () => Navigator.pop(context),
            onFavouriteToggle: () {
              setState(() {
                isFavourite = !isFavourite;
              });
              print("favvvvvvvvvvvvvvvvvvvv");
            },
          ),
          SliverToBoxAdapter(
            child: Column(
                mainAxisSize: MainAxisSize.min, 
              children: [
                //Product Image Slider
                imageSlider(
                  imagePaths: getImagesList(),
                ),

                // product details
                Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(AppPadding.p18),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          // product name and  product price
                          Product_Name_Price(
                            productID: widget.productId,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // starts rating
                          starsRating(rate: rate, numOfRatings: numOfRatings),

                          SizedBox(
                            height: 15,
                          ),
                          // normal line
                          Divider(thickness: 0.1, height: 0.5),
                          SizedBox(
                            height: 10,
                          ),
                          // colors and sizes of product
                          product_color_size(
                              currentImage: _currentImage,
                              currentColor: _currentColor,
                              CurrentSize: _CurrentSize,
                              selectedColor: _selectedColor,
                              selectedSize: _selectedSize,
                              clrs: clrs,
                              txt: txt),

                          SizedBox(
                            height: 10,
                          ),
                          // normal line
                          Divider(
                            thickness: .1,
                            height: 0.5,
                          ),
                          // product discription
                          Productdiscription(
                            productID: widget.productId,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // normal line
                          Divider(
                            thickness: .1,
                            height: 0.5,
                          ),
                          //Reviews
                          Productreviews(
                              numOfRatings: numOfRatings,
                              ratingNumber: ratingNumber,
                              numOfReviews: numOfReviews,
                              nums: nums,
                              percentages: percentages),

                          SizedBox(
                            height: 5,
                          ),
                          // normal line
                          Divider(
                            thickness: 0.1,
                            height: 0.5,
                          ),
                          // Simial Products
                          simialProducts(
                              productNames: productNames,
                              similarProductPrices: similarProductPrices),
                        ],
                      ),
                    )
                    ////////////////////////////////////////////////////////////////////////

                    ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        height: 60,
        // margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            ),
          ),
          onPressed: () {
            print("Button Pressed");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Add to Cart",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: FontConstants.fontFamily,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/**    
       
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            SizedBox(
              //height: 350,
              child: Stack(
                children: [
                  // Circle avatar and images slider
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: clrs[_selectedColor],
                          radius: 110,
                        ),
                        // Image Slider
                        CarouselSlider(
                          items: getImagesList()
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
                        // Circle Indicators
                        Positioned(
                          top: 320,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < getImagesList().length; i++)
                                GestureDetector(
                                  child: Container(
                                    width: 18,
                                    child: _currentImage == i
                                        ? Icon(
                                            Icons.circle,
                                            size: 10,
                                          )
                                        : Icon(
                                            Icons.circle_outlined,
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

                  // Back button
                  Positioned(
                    left: 10,
                    top: 14,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              Theme.of(context).colorScheme.onPrimary),
                        ),
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        )),
                  ),
                  //Fav. button
                  Positioned(
                    right: 10,
                    top: 14,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            isFavourite = true;
                            print("favvvvvvvvvvvvvvvvvvvv");
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                        ),
                        icon: Icon(
                          Icons.favorite_rounded,
                          color: isFavourite
                              ? Colors.red
                              : Theme.of(context).colorScheme.surface,
                          size: 20,
                        )),
                  ),
                ],
              ),
            ),

            // product details
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // product name and  product price
                      Row(
                        children: [
                          // product name
                          Text(
                            "$productName",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontConstants.fontFamily),
                          ),
                          Spacer(),
                          // product price
                          Text(" \$ $productPrice",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontConstants.fontFamily))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // starts rating
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return IconButton(
                                padding: EdgeInsets.all(0),
                                constraints: BoxConstraints(),
                                onPressed: () {
                                  setState(() {
                                    rate = index + 1;
                                  });
                                },
                                icon: Icon(index < rate
                                    ? Icons.star
                                    : Icons.star_border),
                                color: index < rate
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).primaryColor,
                              );
                            }),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "($numOfRatings)",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontConstants.fontFamily,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      // normal line
                      Divider(thickness: 0.1, height: 0.5),
                      SizedBox(
                        height: 10,
                      ),
                      // colors and sizes of product
                      Row(
                        children: [
                          //product colors
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Color",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontConstants.fontFamily),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: List.generate(3, (index) {
                                  return IconButton.filled(
                                    onPressed: () {
                                      setState(() {
                                        if (_currentColor[index] == false) {
                                          for (int i = 0;
                                              i < _currentColor.length;
                                              i++) {
                                            _currentColor[i] = false;
                                          }
                                          _currentColor[index] = true;
                                          _selectedColor = index;
                                          _currentImage = 0;
                                        }
                                      });
                                    },
                                    iconSize: _currentColor[index] ? 40 : 35,
                                    padding: EdgeInsets.all(0),
                                    constraints: BoxConstraints(),
                                    icon: Icon(
                                      Icons.circle,
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty
                                            .all(_currentColor[index]
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .shadow
                                                : Theme.of(context)
                                                    .scaffoldBackgroundColor)),
                                    color: clrs[index],
                                  );
                                }),
                              ),
                            ],
                          ),
                          Spacer(),
                          // product sizes
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Size",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontConstants.fontFamily),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: List.generate(3, (index) {
                                  return CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_CurrentSize[index] == false) {
                                            for (int i = 0;
                                                i < _CurrentSize.length;
                                                i++) {
                                              _CurrentSize[i] = false;
                                            }
                                            _CurrentSize[index] = true;
                                            _selectedSize = index;
                                            _currentImage = 0;
                                          }
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: _CurrentSize[index]
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                            : Colors.transparent,
                                        foregroundColor: Colors.transparent,
                                      ),
                                      child: Text(
                                        txt[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: _CurrentSize[index]
                                                ? Theme.of(context)
                                                    .scaffoldBackgroundColor
                                                : Theme.of(context)
                                                    .primaryColor),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // normal line
                      Divider(
                        thickness: .1,
                        height: 0.5,
                      ),
                      // product discription
                      ExpansionTile(
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
                              "$productDescription",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: FontConstants.fontFamily,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      // normal line
                      Divider(
                        thickness: .1,
                        height: 0.5,
                      ),
                      ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        shape: Border.all(color: Colors.transparent),
                        collapsedShape: Border.all(color: Colors.transparent),
                        title: Text(
                          "Reviews",
                          style: TextStyle(
                              fontFamily: FontConstants.fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                        children: [
                          // the rating of the product
                          Card(
                            color: Theme.of(context).colorScheme.onPrimary,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      // Rating number
                                      Text(
                                        "$ratingNumber",
                                        style: TextStyle(
                                            fontSize: 40,
                                            fontFamily:
                                                FontConstants.fontFamily,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(
                                        " OUT OF 5",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontFamily: FontConstants.fontFamily,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      //Actual Rating of this product
                                      Column(
                                        children: [
                                          //Actual Rating of this product
                                          Row(
                                            children: [
                                              for (int i = 0; i < 5; i++)
                                                Icon(
                                                  Icons.star,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  size: 20,
                                                ),
                                            ],
                                          ),
                                          Text("$numOfRatings rating",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                // fontSize: 10,
                                                fontFamily:
                                                    FontConstants.fontFamily,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Indicators
                                  for (int i = 0; i < 5; i++) drawIndicators(i),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "$numOfReviews Reviews",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontFamily: FontConstants.fontFamily,
                                ),
                              ),
                              Spacer(),
                              Text("WRITE A REVIEW",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontFamily: FontConstants.fontFamily,
                                  )),
                              SizedBox(
                                width: 3,
                              ),
                              IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        showDragHandle: true,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller: addReview,
                                                    decoration: InputDecoration(
                                                        label: Text(
                                                          "Add Your Review",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  FontConstants
                                                                      .fontFamily,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStateProperty
                                                                .all(Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary)),
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Add",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                        fontFamily:
                                                            FontConstants
                                                                .fontFamily,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  padding: EdgeInsets.all(0),
                                  constraints: BoxConstraints(),
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    size: 25,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // The Review of The Product
                          for (int i = 0; i < 2; i++)
                            drawReview([
                              'assets/images/welcomePic.png',
                              'assets/images/3rdOnboardingPic.jpg'
                            ], i),
                        ],
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      // normal line
                      Divider(
                        thickness: 0.1,
                        height: 0.5,
                      ),
                      // Simial Products
                      ExpansionTile(
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
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsScreen()),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            width: 126,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.red,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.asset(
                                                'assets/images/iconDark.png',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),

                                        //similar product name

                                        Text(
                                          "${productNames[index]}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily:
                                                  FontConstants.fontFamily,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),

                                        //similar product price
                                        Text(
                                          "\$ ${similarProductPrices[index]}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily:
                                                  FontConstants.fontFamily,
                                              fontWeight:
                                                  FontWeightManager.bold,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ],
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                ////////////////////////////////////////////////////////////////////////

                ),
          ],
        ),
      ),
       
 */