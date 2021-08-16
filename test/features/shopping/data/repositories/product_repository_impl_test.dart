import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/error/exceptions.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_local_datasource.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_remote_datasource.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/data/repositories/product_repository_impl.dart';
import 'package:shopping_app/features/shopping/domain/entities/product.dart';

/*
@GenerateMocks([ProductRemoteDataSource, ProductLocalDataSource, NetworkInfo])
void main() {
  MockProductLocalDataSource mockProductLocalDataSource = MockProductLocalDataSource();
  MockProductRemoteDataSource mockProductRemoteDataSource = MockProductRemoteDataSource();
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  ProductRepositoryImpl productRepositoryImpl = ProductRepositoryImpl(
      remoteDataSource: mockProductRemoteDataSource,
      localDataSource: mockProductLocalDataSource,
      networkInfo: mockNetworkInfo);

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getProduct', () {
    final int id = 1;
    final ProductModel productModel =
        ProductModel(productId: 1, categoryId: 1, productName: "Keyboard", price: 25.99, discount: 0);
    final Product product = productModel;

    /*
    test('should check the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      await productRepositoryImpl.getProduct(id);
      // assert
      verify(mockNetworkInfo.isConnected);
    });
    */

    runTestsOnline(() {
      test('should return remote data when the call to remote data source is successful', () async {
        // arrange
        when(mockProductRemoteDataSource.getProduct(any)).thenAnswer((_) async => productModel);
        // act
        final result = await productRepositoryImpl.getProduct(id);
        //assert
        verify(mockProductRemoteDataSource.getProduct(id));
        expect(result, equals(Right(product)));
      });

      test('should cache the data locally when the call to remote data source is successful', () async {
        // arrange
        when(mockProductRemoteDataSource.getProduct(any)).thenAnswer((_) async => productModel);
        // act
        await productRepositoryImpl.getProduct(id);
        //assert
        verify(mockProductRemoteDataSource.getProduct(id));
        verify(mockProductLocalDataSource.cacheProduct(productModel));
      });

      test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(mockProductRemoteDataSource.getProduct(any)).thenThrow(ServerException());
        // act
        final result = await productRepositoryImpl.getProduct(id);
        //assert
        verify(mockProductRemoteDataSource.getProduct(id));
        verifyZeroInteractions(mockProductLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test('should return last locally cached data when the cache data is present', () async {
        // arrange
        when(mockProductLocalDataSource.getLastProduct()).thenAnswer((_) async => productModel);
        // act
        final result = await productRepositoryImpl.getProduct(id);
        //assert
        verifyZeroInteractions(mockProductRemoteDataSource);
        verify(mockProductLocalDataSource.getLastProduct());
        expect(result, equals(Right(product)));
      });

      test('should return CacheFailure when there is no cached data present', () async {
        // arrange
        when(mockProductLocalDataSource.getLastProduct()).thenThrow(CacheException());
        // act
        final result = await productRepositoryImpl.getProduct(id);
        //assert
        verifyZeroInteractions(mockProductRemoteDataSource);
        verify(mockProductLocalDataSource.getLastProduct());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
*/
