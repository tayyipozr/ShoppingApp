import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_categories.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_products_by_categories.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  MockProductRepository repository;
  GetProductsByCategories useCase;

  setUp((){
    repository = MockProductRepository();
    useCase = GetProductsByCategories(repository);
  });
  final Iterable decoded = jsonDecode(fixture('jewelery_products.json'));
  final List<ProductModel> products = decoded.map((product) => ProductModel.fromJson(product)).toList();

  test(
    'should get products on jewelery category from the repository',
        () async {
      // arrange
      when(repository.getProductsByCategory(any)).thenAnswer((_) async => Right(products));
      // act
      final result = await useCase(Params.name("jewelery"));
      // assert
      expect(result, Right(products));
      verify(repository.getProductsByCategory("jewelery"));
      verifyNoMoreInteractions(repository);
    },
  );

}
