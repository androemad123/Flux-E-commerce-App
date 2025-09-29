import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBLoC extends Bloc<ProductEvent, ProductState> {
  ProductBLoC() : super(ProductState(product: [])) {
    on<LoadProduct>(
      (event, emit) {
        emit(ProductState(product: state.product)); // Must Pass The Actual Data
      },
    );

    on<AddProduct>((event, emit){
      int productID = (DateTime.now().millisecondsSinceEpoch) % 0xFFFFFFFF;

      final newProduct = List<Product>.from(state.product)
        ..add(Product(
            ProductID: productID,
            ProductName: event.ProductName,
            ProductDescription: event.ProductDescription,
            ProductCategotry: event.ProductCategotry,
            ProductPrice: event.ProductPrice,
            ProductImageURL: event.ProductImageURL,
            ProductQuantity: event.ProductQuantity,
            ProductUserQuantity: 0,
            isProductFavourate: false,
            isProductInCart: false,
            isProductBuyed: false));
      emit(ProductState(product: newProduct));
    });

    on<DeleteProduct>(
      (event, emit) {
        final AllProducts = List<Product>.from(state.product);
        final index =
            AllProducts.indexWhere((p) => p.ProductID == event.ProductID);
        final deletedProduct = List<Product>.from(state.product)
          ..removeAt(index);
        emit(ProductState(product: deletedProduct));
      },
    );

    on<BuyedProduct>(
      (event, emit) {
        final AllProducts = List<Product>.from(state.product);
        final index =AllProducts.indexWhere((p) => p.ProductID == event.ProductID);
        Product UpdatedProduct = AllProducts.elementAt(index);
        int x = UpdatedProduct.ProductQuantity;
        UpdatedProduct.ProductQuantity = x - UpdatedProduct.ProductUserQuantity;
        if (UpdatedProduct.ProductQuantity <= 0) {
          UpdatedProduct.isProductBuyed = !UpdatedProduct.isProductBuyed;
        }

        AllProducts[index] = UpdatedProduct;
        emit(ProductState(product: AllProducts));
      },
    );

    on<UserProducts>(
      (event, emit) {
        final AllProducts = List<Product>.from(state.product);
        final index =
            AllProducts.indexWhere((p) => p.ProductID == event.ProductID);
        Product UpdatedProduct = AllProducts.elementAt(index);

        if(UpdatedProduct.ProductUserQuantity<UpdatedProduct.ProductQuantity){
           UpdatedProduct.ProductUserQuantity++;

        }

       

        AllProducts[index] = UpdatedProduct;
        emit(ProductState(product: AllProducts));
      },
    );

    on<FavProduct>(
      (event, emit) async {
        final AllProducts = List<Product>.from(state.product);
        final index =
            AllProducts.indexWhere((p) => p.ProductID == event.ProductID);
        Product UpdatedProduct = AllProducts.elementAt(index);
        if (UpdatedProduct != null) {
          UpdatedProduct.isProductFavourate =
              !UpdatedProduct.isProductFavourate;
        }

        AllProducts[index] = UpdatedProduct;

        emit(ProductState(product: AllProducts));
      },
    );

    on<CartProduct>(
      (event, emit) async {
        final AllProducts = List<Product>.from(state.product);
        final index =
            AllProducts.indexWhere((p) => p.ProductID == event.ProductID);
        Product UpdatedProduct = AllProducts.elementAt(index);
        if (UpdatedProduct != null) {
          UpdatedProduct.isProductInCart = !UpdatedProduct.isProductInCart;
        }

        AllProducts[index] = UpdatedProduct;

        emit(ProductState(product: AllProducts));
      },
    );

    on<EditProduct>(
      (event, emit) async {
        final AllProducts = List<Product>.from(state.product);
        final index =
            AllProducts.indexWhere((p) => p.ProductID == event.ProductID);
        Product UpdatedProduct = AllProducts.elementAt(index);
        if (UpdatedProduct != null) {
          UpdatedProduct.ProductName = event.ProductName;
          UpdatedProduct.ProductDescription = event.ProductDescription;
          UpdatedProduct.ProductCategotry = event.ProductCategotry;
          UpdatedProduct.ProductPrice = event.ProductPrice;
          UpdatedProduct.ProductImageURL = event.ProductImageURL;
          UpdatedProduct.ProductPrice = event.ProductPrice;
        }

        AllProducts[index] = UpdatedProduct;

        emit(ProductState(product: AllProducts));
      },
    );
  }
}
