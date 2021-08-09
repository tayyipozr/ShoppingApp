import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:cubit/cubit.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_product.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_products.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_products_by_categories.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts _getProductsUseCase;
  final GetProduct _getProductUseCase;
  final GetProductsByCategories _getProductsByCategories;

  ProductCubit(this._getProductsUseCase, this._getProductUseCase, this._getProductsByCategories) : super(ProductInitial());

  Future<void> getProduct(int productId) async {
    emit(ProductLoading());
    final response = await _getProductUseCase(Params.id(productId));
    response.fold((failure) {
      emit(ProductError(failure is ServerFailure ? "Check your internet connection" : "An error occured"));
      }, (product) {
      emit(ProductLoaded(product));
    });
  }

  Future<void> getProducts() async {
    emit(ProductLoading());
    final response = await _getProductsUseCase(NoParams());
    response.fold((failure) {
      emit(ProductError(failure is ServerFailure ? "Check your internet connection" : "An error occured"));
      }, (products) {
      emit(ProductsLoaded(products));
    });
  }

  Future<void> filterProductsByCategories(String categoryName) async {
    emit(ProductLoading());
    final response = await _getProductsByCategories(Params.name(categoryName));
    response.fold((failure) {
      emit(ProductError(failure is ServerFailure ? "Check your internet connection" : "An error occured"));
    }, (products) {
      emit(ProductsLoaded(products));
    });
  }
}
