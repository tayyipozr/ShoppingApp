import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_product.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_products.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_products_by_categories.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/product_cubit.dart';

import '../../../../fixtures/fixture_reader.dart';


class MockGetProducts extends Mock implements GetProducts {}

class MockGetProduct extends Mock implements GetProduct {}

class MockGetProductsByCategories extends Mock implements GetProductsByCategories {}

void main() {
  ProductCubit cubit;
  MockGetProduct mockGetProduct;
  MockGetProducts mockGetProducts;
  MockGetProductsByCategories mockGetProductsByCategories;

  setUp(() {
    mockGetProducts = MockGetProducts();
    mockGetProduct = MockGetProduct();
    mockGetProductsByCategories = MockGetProductsByCategories();
    cubit = ProductCubit(mockGetProducts, mockGetProduct, mockGetProductsByCategories);
  });


  test('get product usecase should return list of product', () async {
    // arrange
    when(cubit.getProduct(any)).thenAnswer((_) => Future.value(Right(ProductModel.fromJson(jsonDecode(fixture('product'
        '.json'))))));
    // act
    final result = await cubit.getProduct(1);
    // expect
    expect(cubit.state, isNotNull);
  });
}
