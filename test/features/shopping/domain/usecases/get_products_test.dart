import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_products.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockProductRepository extends Mock implements ProductRepository {}


void main() {
  MockProductRepository repository;
  GetProducts useCase;

  setUp(() {
    repository = MockProductRepository();
    useCase = GetProducts(repository);
  });

  final Iterable decoded = jsonDecode(fixture('products.json'));
  final List<ProductModel> products = decoded.map((product) => ProductModel.fromJson(product)).toList();
  test(
    'should get products from the repository',
        () async {
      // arrange
      when(repository.getProducts()).thenAnswer((_) async => Right(products));
      // act
      final result = await useCase(NoParams());
      // assert
      expect(result, Right(products));
      verify(repository.getProducts());
      verifyNoMoreInteractions(repository);
    },
  );

}
