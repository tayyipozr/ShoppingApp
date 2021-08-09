import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/entities/product.dart';

import '../../../../fixtures/fixture_reader.dart';

/*
void main() {
  final tProductModel = ProductModel();

  test('should be a subclass of Product entity', () async {
    expect(tProductModel, isA<Product>());
  });

  group('from json ', () {
    test('should return a valid model when the json productId, categoryId are integer', () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('product.json'));
      // act
      final result = ProductModel.fromJson(jsonMap);
      // assert
      expect(result, tProductModel);
    });

    /*
    test('should return a valid model when the json productId, categoryId are double', () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('product_double.json'));
      // act
      final result = ProductModel.fromJson(jsonMap);
      // assert
      expect(result, tProductModel);
    });
    */
  });

  group('to json ', () {
    test('should return a map containing proper data', () async {
      // arrange
      final expectedMap = {"productId": 1, "categoryId": 1, "productName": "Keyboard", "price": 35.5, "discount": 0};
      // act
      final result = tProductModel.toJson();
      // assert
      expect(result, expectedMap);
    });
  });
}
*/
