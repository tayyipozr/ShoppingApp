import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_product.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  MockProductRepository repository;
  GetProduct useCase;
  
  setUp((){
    repository = MockProductRepository();
    useCase = GetProduct(repository);
  });
  
  final ProductModel product = ProductModel.fromJson(jsonDecode(fixture('product.json')));

  test(
    'should get product from the repository',
        () async {
      // arrange
      when(repository.getProduct(1)).thenAnswer((_) async => Right(product));
      // act
      final result = await useCase(Params.id(1));
      // assert
      expect(result, Right(product));
      verify(repository.getProduct(1));
      verifyNoMoreInteractions(repository);
    },
  );

}
