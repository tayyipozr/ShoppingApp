import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/entities/product.dart';

import '../../../../fixtures/fixture_reader.dart';


void main() {
  final productModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));

  test('should be a subclass of Product entity', ()  {
    expect(productModel, isA<Product>());
  });

  group('from json ', () {
    test('should return a valid model when the json productId, categoryId are integer', () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('product.json'));
      // act
      final result = ProductModel.fromJson(jsonMap);
      // assert
      expect(result, productModel);
    });

  });

  group('to json ', () {
    test('should return a map containing proper data', () async {
      // arrange
      final expectedMap = {"productId": 1, "categoryId": 1, "productName": "Keyboard", "price": 35.5, "discount": 0};
      // act
      final result = productModel.toJson();
      // assert
      expect(result, expectedMap);
    });
  });
}

