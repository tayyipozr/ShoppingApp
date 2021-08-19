import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/profile/domain/repositories/user_repository.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/delete_cart.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_categories.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  MockUserRepository repository;
  DeleteCart useCase;

  setUp((){
    repository = MockUserRepository();
    useCase = DeleteCart(repository);
  });
  final ProductModel product = ProductModel.fromJson(jsonDecode(fixture('product.json')));

  test(
    'should get the categories from the repository',
        () async {
      // arrange
      when(repository.deleteCart(product)).thenAnswer((_) async => Right(true));
      // act
      final result = await useCase(Params.product(product));
      // assert
      expect(result, Right(true));
      verify(repository.deleteCart(product));
      verifyNoMoreInteractions(repository);
    },
  );

}
