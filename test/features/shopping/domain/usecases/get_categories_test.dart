import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_categories.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_product.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  MockProductRepository repository;
  GetCategories useCase;

  setUp((){
    repository = MockProductRepository();
    useCase = GetCategories(repository);
  });
  final Iterable decoded = jsonDecode(fixture('categories.json'));
  List<String> categories = decoded.map((string) => string.toString()).toList();

  test(
    'should get the categories from the repository',
        () async {
      // arrange
      when(repository.getCategories()).thenAnswer((_) async => Right(categories));
      // act
      final result = await useCase(NoParams());
      // assert
      expect(result, Right(categories));
      verify(repository.getCategories());
      verifyNoMoreInteractions(repository);
    },
  );

}
