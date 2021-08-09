import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial();

}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductsLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductsLoaded(this.products);
}

class ProductLoaded extends ProductState {
  final ProductModel product;

  const ProductLoaded(this.product);
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);
}
