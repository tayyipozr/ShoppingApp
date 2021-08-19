import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/error/exceptions.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_local_datasource.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_remote_datasource.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/data/repositories/product_repository_impl.dart';
import 'package:shopping_app/features/shopping/domain/entities/product.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockProductLocalDataSource extends Mock implements ProductLocalDataSource {}

class MockProductRemoteDataSource extends Mock implements ProductRemoteDataSource {}

void main() {
  MockProductLocalDataSource mockProductLocalDataSource;
  MockProductRemoteDataSource mockProductRemoteDataSource;
  ProductRepositoryImpl productRepositoryImpl;
  setUp(() {
    mockProductLocalDataSource = MockProductLocalDataSource();
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    productRepositoryImpl = ProductRepositoryImpl(
        remoteDataSource: mockProductRemoteDataSource, localDataSource: mockProductLocalDataSource);
  });

  group('getProduct', () {
    final int id = 1;
    final ProductModel productModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));
    final Product product = productModel;

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
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockProductRemoteDataSource.getProduct(any)).thenThrow(ServerException());
      // act
      final result = await productRepositoryImpl.getProduct(id);
      //assert
      verify(mockProductRemoteDataSource.getProduct(id));
      verifyZeroInteractions(mockProductLocalDataSource);
      expect(result,  isA<Left<Failure, ProductModel>>());
    });
  });
}
