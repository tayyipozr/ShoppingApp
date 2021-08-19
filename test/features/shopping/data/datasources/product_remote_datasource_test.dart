import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/error/exceptions.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_remote_datasource.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_remote_datasource_test.mocks.dart' as M;

@GenerateMocks([http.Client])
void main() {
  M.MockClient mockClient = M.MockClient();
  ProductRemoteDataSource productRemoteDataSource = ProductRemoteDataSourceImpl(mockClient);

  /*
  group('get product with product Id', () {
    final id = 1;
    final ProductModel productModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));

    test('should perform a Get request on a url number being the endpoint and with application/json header', () async {
      // arrange
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('product.json'), 200));
      // act
      await productRemoteDataSource.getProduct(id);
      // assert
      verify(
        mockClient.get(
          Uri.parse('https://fakestoreapi.com/products/1'),
          headers: {'Content-Type': 'application/json; charset=utf-8'},
        ),
      ).called(1);
    });

    test('should return product when the response is 200', () async {
      // arrange
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('product.json'), 200));
      // act
      final result = await productRemoteDataSource.getProduct(id);
      // assert
      expect(result, equals(productModel));
    });

    test('method should throw a server exception when the response code is 404', () async {
      // arrange
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
      // act
      final call = productRemoteDataSource.getProduct;
      // assert
      expect(() => call(id), throwsA(isInstanceOf<ServerException>()));
    });
  });
   */

  group('get products', () {

    test('should perform a Get request on a url number being the endpoint and with application/json header', () async {
      // arrange
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async =>
          http.Response(fixture('products.json'), 200, headers: {'Content-Type': 'application/json; charset=utf-8'}));
      // act
      productRemoteDataSource.getProducts();
      // assert
      verify(
        mockClient.get(Uri.parse('https://fakestoreapi.com/products'),
            headers: {'Content-Type': 'application/json; charset=utf-8'}),
      ).called(1);
    });

    test('should return product list when the response is 200', () async {
      // arrange
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async =>
          http.Response(fixture('products.json'), 200, headers: {'Content-Type': 'application/json; charset=utf-8'}));
      // act
      final result = await productRemoteDataSource.getProducts();
      // assert
      expect(result, isA<List<ProductModel>>());
    });

    test('method should throw a server exception when the response code is 404', () async {
      // arrange
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
      // act
      final call = productRemoteDataSource.getProducts;
      // assert
      expect(() => call(), throwsA(isInstanceOf<ServerException>()));
    });

    /*
    group('get categories', () {
      final Iterable decoded = jsonDecode(fixture('categories.json'));
      final List<String> strings = decoded.map((category) => category.toString()).toList();

      test('should perform a Get request on a url number being the endpoint and with application/json header',
          () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(
            fixture('categories.json'), 200,
            headers: {'Content-Type': 'application/json; charset=utf-8'}));
        // act
        productRemoteDataSource.getCategories();
        // assert
        verify(
          mockClient.get(Uri.parse('https://fakestoreapi.com/products/categories'),
              headers: {'Content-Type': 'application/json; charset=utf-8'}),
        ).called(1);
      });

      test('should return category list when the response is 200', () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(
            fixture('categories.json'),
            200,
            headers: {'Content-Type': 'application/json; charset=utf-8'},
          ),
        );
        // act
        final result = await productRemoteDataSource.getCategories();
        // assert
        expect(result, isA<List<String>>());
      });

      test('method should throw a server exception when the response code is 404', () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('Something went wrong', 404));
        // act
        final call = productRemoteDataSource.getCategories;
        // assert
        expect(() => call(), throwsA(isInstanceOf<ServerException>()));
      });
    });
     */
  });
}
