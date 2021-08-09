import 'dart:convert';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/features/shopping/data/datasources/product_local_datasource.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_local_datasource_test.mocks.dart';


@GenerateMocks([SharedPreferences])
void main() {
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  ProductLocalDataSource dataSource = ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  
  group('getLastProduct', () {
    final ProductModel productModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));
    test('should return Product model', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture('product.json'));
      // act
      final result = await dataSource.getLastProduct();
      // assert
      verify(mockSharedPreferences.getString(CACHED_PRODUCT));
      expect(result, equals(productModel));
    });
  });
}
