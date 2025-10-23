import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/firebase_services/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class ProductBLoC extends Bloc<ProductEvent, ProductState> {
  final firestore = FirestoreService<Product>(
      collection: "products",
      fromJson: (json) => Product.fromJson(json),
      toJson: (product) => product.tojson());

  ProductBLoC() : super(initialState(products: [])) {
    on<LoadAllProducts>(
      (event, emit) async {
        emit(ProductLoading());
        List<Product?> products = await firestore.getAll();
        if (products.isEmpty) {
          emit(ErrorState(errorMSG: "Products Not Found"));
        } else {
          emit(AllProductsLoaded(products: products));
        }
      },
    );

    on<LoadProduct>(
      (event, emit) async {
        emit(ProductLoading());
        Product? product = await firestore.get(event.ProductID);
        if (product == null)
          emit(ErrorState(errorMSG: "Product Not Found"));
        else {
          emit(ProductLoaded(product: product));
        }
      },
    );

    on<LoadSpecificProduct>(
      (event, emit) async {
        emit(ProductLoading());

        List<Product?> products =
            await firestore.getWhere(event.field, event.isEqualTo);
        if (products.isEmpty) {
          emit(ErrorState(errorMSG: "Products Not Found"));
        } else {
          emit(SpecificProducts(products: products));
        }
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
