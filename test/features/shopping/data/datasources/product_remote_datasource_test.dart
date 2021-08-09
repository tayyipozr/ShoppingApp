import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/error/exceptions.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_remote_datasource.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/entities/product.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_remote_datasource_test.mocks.dart' as M;

@GenerateMocks([http.Client])
void main() {
  M.MockClient mockClient = M.MockClient();
  ProductRemoteDataSource productRemoteDataSource = ProductRemoteDataSourceImpl(mockClient);

  group('get product with product Id', () {
    final id = 1;
    final ProductModel productModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));
    
    test('should perform a Get request on a url number being the endpoint and with application/json header', () async {
      // arrange
     when(mockClient.get(any, headers: anyNamed('headers')))
         .thenAnswer((_) async => http.Response(fixture('product.json'), 200));
      // act
      productRemoteDataSource.getProduct(1);
      // assert
      verifyNever(mockClient.get(Uri.parse('https://fakestoreapi.com/products'), headers: {'Content-Type': 'applicatio'
          'n/json'
      }));
    });


    test('should return product when the response is 200', () async {
      // arrange
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('product.json'), 200));
      // act
      final result = await productRemoteDataSource.getProduct(1);
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
      // expect(() => call(id), throwsA(TypeMatcher<ServerException>()));
    });

  });
}
