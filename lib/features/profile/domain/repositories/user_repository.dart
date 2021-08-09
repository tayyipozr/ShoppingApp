import 'package:dartz/dartz.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserInfo();
  Future<Either<Failure, bool>> addCart(ProductModel product);
  Future<Either<Failure, bool>> addFavorite(ProductModel product);
  Future<Either<Failure, List<ProductModel>>> getCart();
  Future<Either<Failure, List<ProductModel>>> getFavorites();
}
