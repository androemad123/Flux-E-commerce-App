// import 'dart:convert';
// import 'dart:io';

// import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
// import 'package:depi_graduation/data/ProductData/intialProducts.dart';
// import 'package:path_provider/path_provider.dart';

// Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();
//   return directory.path;
// }

// Future<File> get _localfile async {
//   String path = await _localPath;
//   File file = File("$path/ProductData.json");

//   if (!(await file.exists())) {
//     await _saveProducts(initialProducts);
//   } else if ((await file.readAsString()).isEmpty) {
//     await _saveProducts(initialProducts);
//   }

//   return file;
// }

// Future<void> _saveProducts(List<Product> products) async {
//   File file = await _localfile;
//   String jsonData = await json.encode(products.map((e) => e.tojson()).toList());
//   await file.writeAsString(jsonData);
// }

// Future<List<Product>> loadAllProducts() async {
//   File file = await _localfile;

//   String jsonData = await file.readAsString();
//   List<dynamic> content = json.decode(jsonData);
//   return content.map((e) => Product.fromJson(e)).toList();
// }

// Future<Product> loadProduct(String id) async {
//   List<Product> allProducts = await loadAllProducts();
//   print('Looking for ID: $id');
//   print('Available IDs: ${allProducts.map((p) => p.ProductID).toList()}');
//   final index = allProducts.indexWhere((p) => p.ProductID == id);

//   if (index != -1) {
//     return allProducts[index];
//   } else
//     return Product(
//         ProductID: "",
//         ProductName: "",
//         ProductDescription: "",
//        // ProductCategotry: "",
//         ProductColors: [],
//         ProductSizes: [],
//         ProductPrice: -1,
//         ProductImageURL: [],
//         ProductQuantity: -1,
//        // isProductBuyed: false
//         );
// }

// Future<List<Product>> loadCategoryProduct(String ProductCategotry) async {
//   List<Product> allProducts = await loadAllProducts();
//   List<Product> x =
//       allProducts.where((p) => p.ProductCategotry == ProductCategotry).toList();
//   return x;
// }
