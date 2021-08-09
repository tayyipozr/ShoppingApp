import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/features/profile/data/datasource/user_local_datasource.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/profile/domain/repositories/user_repository.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  // final NetworkInfo networkInfo;

  UserRepositoryImpl({@required this.localDataSource});

  @override
  Future<Either<Failure, bool>> addCart(ProductModel product) async {
    try {
      final response = await localDataSource.addCart(product);
      return Right(response);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addFavorite(ProductModel product) async {
    try {
      final response = await localDataSource.addFavorite(product);
      return Right(response);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserInfo() async {
    try {
      final user = await localDataSource.getUserInfo();
      return Right(user);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getCart() async {
    try {
      final cart =  localDataSource.getCart();
      return Right(cart);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getFavorites() async {
    try {
      final favorites = localDataSource.getFavorites();
      return Right(favorites);
    } on Exception {
      return Left(CacheFailure());
    }
  }



}
