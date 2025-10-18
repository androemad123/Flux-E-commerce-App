import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

List<Product> initialProducts = [
  // Women Products
  Product(
    ProductID: uuid.v4(),
    ProductName: "Maxi Dress",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Women",
    ProductColors: [ Color(0xFFF44336), Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 15500.00,
    ProductImageURL: "assets/images/3rdOnboardingPic.jpg",
    ProductQuantity: 10,
    isProductBuyed: false,
  ),
  Product(
    ProductID: uuid.v4(),
    ProductName: "Front Tie Mini Dress",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Women",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 50000.00,
    ProductImageURL: "assets/images/2ndOnboardingPic.jpg",
    ProductQuantity: 5,
    isProductBuyed: false,
  ),
  Product(
    ProductID: uuid.v4(),
    ProductName: "Tie Back Mini Dress",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Women",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 1000.00,
    ProductImageURL: "assets/images/1stOnboardingPic.jpg",
    ProductQuantity: 5,
    isProductBuyed: false,
  ),
  Product(
    ProductID: uuid.v4(),
    ProductName: "Mini Dress",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Women",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 1500.00,
    ProductImageURL: "assets/images/3rdOnboardingPic.jpg",
    ProductQuantity: 35,
    isProductBuyed: false,
  ),

  // Men Products
  Product(
    ProductID: uuid.v4(),
    ProductName: "Ohara",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Men",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 5700.00,
    ProductImageURL: "assets/images/2ndOnboardingPic.jpg",
    ProductQuantity: 55,
    isProductBuyed: false,
  ),
  Product(
    ProductID: uuid.v4(),
    ProductName: "Leaves Green",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Men",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 100.00,
    ProductImageURL: "assets/images/1stOnboardingPic.jpg",
    ProductQuantity: 17,
    isProductBuyed: false,
  ),
  Product(
    ProductID: uuid.v4(),
    ProductName: "Leaves Green ",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Men",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 50000.00,
    ProductImageURL: "assets/images/2ndOnboardingPic.jpg",
    ProductQuantity: 5,
    isProductBuyed: false,
  ),
  Product(
    ProductID: uuid.v4(),
    ProductName: "Black Shirt",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Men",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 330.00,
    ProductImageURL: "assets/images/3rdOnboardingPic.jpg",
    ProductQuantity: 83,
    isProductBuyed: false,
  ),
  // Accessories Products
  Product(
    ProductID: uuid.v4(),
    ProductName: "Watch",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Accessories",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 753.00,
    ProductImageURL: "assets/images/3rdOnboardingPic.jpg",
    ProductQuantity: 100,
    isProductBuyed: false,
  ),
  Product(
    ProductID: uuid.v4(),
    ProductName: "Glasses",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Accessories",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 95.00,
    ProductImageURL: "assets/images/2ndOnboardingPic.jpg",
    ProductQuantity: 3,
    isProductBuyed: false,
  ),
  Product(
    ProductID: uuid.v4(),
    ProductName: "Bin",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Accessories",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 80.00,
    ProductImageURL: "assets/images/1stOnboardingPic.jpg",
    ProductQuantity: 5,
    isProductBuyed: false,
  ),
// Beauty Products
  Product(
    ProductID: uuid.v4(),
    ProductName: "Foundation Creame",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Beauty",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 55.00,
    ProductImageURL: "assets/images/3rdOnboardingPic.jpg",
    ProductQuantity: 15,
    isProductBuyed: false,
  ),
  Product(
    ProductID: uuid.v4(),
    ProductName: "Sunsreen Cream",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Beauty",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 25.00,
    ProductImageURL: "assets/images/1stOnboardingPic.jpg",
    ProductQuantity: 7,
    isProductBuyed: false,
  ),
  Product(
    ProductID: uuid.v4(),
    ProductName: "Soft Cream",
    ProductDescription:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus consequat, orci nec faucibus dapibus, ipsum augue placerat ante, at iaculis lectus arcu quis risus. Ut posuere felis in pretium consectetur.",
    ProductCategotry: "Beauty",
    ProductColors: [Colors.red, Colors.blue, Colors.brown],
    ProductSizes: ["L", "M", "S"],
    ProductPrice: 1000.00,
    ProductImageURL: "assets/images/3rdOnboardingPic.jpg",
    ProductQuantity: 5,
    isProductBuyed: false,
  ),
];
