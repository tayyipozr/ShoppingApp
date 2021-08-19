import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/error/exceptions.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/features/profile/data/datasource/user_local_datasource.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  UserLocalDataSource userLocalDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    userLocalDataSource = UserLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('get user cart', () {
    final List<String> strings = List<String>();
    final String str = fixture('product.json');
    final Map<String, dynamic> decoded = jsonDecode(str);
    strings.add(str);

    final ProductModel productModel = ProductModel.fromJson(decoded);
    final List<ProductModel> products = List<ProductModel>();
    products.add(productModel);


    test('should return list of product when the get Cart called', () async {
      // arrange
      when(mockSharedPreferences.getStringList(any)).thenAnswer((_) => strings);
      // act
      final result = await userLocalDataSource.getCart();
      // assert
      expect(result, equals(products));
    });

    test('should return list of product when the get Cart called', () async {
      // arrange
      when(mockSharedPreferences.getStringList(any)).thenAnswer((_) => strings);
      // act
      final result = await userLocalDataSource.getCart();
      // assert
      expect(result, equals(products));
    });


  });
}
