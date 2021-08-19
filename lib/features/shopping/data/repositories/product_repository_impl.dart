import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/core/error/exceptions.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_local_datasource.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_remote_datasource.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({@required this.localDataSource, @required this.remoteDataSource});

  @override
  Future<Either<Failure, ProductModel>> getProduct(int productId) async {
      try {
        final product = await remoteDataSource.getProduct(productId);
        return Right(product);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      return Right(products);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(String categoryName) async {
    try {
      final categories = await remoteDataSource.getProductsByCategory(categoryName);
      return Right(categories);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
