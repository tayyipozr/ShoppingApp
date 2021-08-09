import 'package:dartz/dartz.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts();
  Future<Either<Failure, ProductModel>> getProduct(int productId);
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(String categoryName);
}
