import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/data/ProductData/JsonProductData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class ProductBLoC extends Bloc<ProductEvent, ProductState> {
  ProductBLoC() : super(ProductState(product: [])) {
    on<LoadAllProducts>(
      (event, emit) async {
        final products = await loadAllProducts();
        emit(ProductState(product: products));
      },
    );

    on<LoadProduct>(
      (event, emit) async {
        Product x = await loadProduct(event.ProductID);
        List<Product> ReturnedProduct = [x];
        emit(ProductState(product: ReturnedProduct));
      },
    );

    on<LoadCategoryProduct>(
      (event, emit) async {
        List<Product> x = await loadCategoryProduct(event.ProductCategotry);
        emit(ProductState(product: x));
      },
    );

    on<AddProduct>(
      (event, emit) async {},
    );

    on<AdminEditProduct>(
      (event, emit) async {},
    );

    on<DeleteProduct>(
      (event, emit) {},
    );
  }
}
