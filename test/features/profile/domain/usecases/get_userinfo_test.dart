import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/profile/domain/repositories/user_repository.dart';
import 'package:shopping_app/features/profile/domain/usecases/get_userinfo.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  MockUserRepository repository;
  GetUserInfo useCase;

  setUp((){
    repository = MockUserRepository();
    useCase = GetUserInfo(repository);
  });

  final Iterable decoded = jsonDecode(fixture('products.json'));
  final List<ProductModel> products = decoded.map((product) => ProductModel.fromJson(product)).toList();

  final User user = User("Tayyip", "ozrtayyip@gmail.com", 21, DateTime.now(), products);

  test(
    'should get the categories from the repository',
        () async {
      // arrange
      when(repository.getUserInfo()).thenAnswer((_) async => Right(user));
      // act
      final result = await useCase(NoParams());
      // assert
      expect(result, Right(user));
      verify(repository.getUserInfo());
      verifyNoMoreInteractions(repository);
    },
  );

}
