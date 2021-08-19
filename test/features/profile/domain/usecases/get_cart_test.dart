import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/profile/domain/repositories/user_repository.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/delete_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/get_cart.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_categories.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  MockUserRepository repository;
  GetCart useCase;

  setUp((){
    repository = MockUserRepository();
    useCase = GetCart(repository);
  });

  final Iterable decoded = jsonDecode(fixture('products.json'));
  final List<ProductModel> products = decoded.map((product) => ProductModel.fromJson(product)).toList();

  test(
    'should get the categories from the repository',
        () async {
      // arrange
      when(repository.getCart()).thenAnswer((_) async => Right(products));
      // act
      final result = await useCase(NoParams());
      // assert
      expect(result, Right(products));
      verify(repository.getCart());
      verifyNoMoreInteractions(repository);
    },
  );

}
