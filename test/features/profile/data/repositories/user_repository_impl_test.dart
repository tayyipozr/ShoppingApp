

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/features/profile/data/datasource/user_local_datasource.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/profile/data/repositories/user_repository_impl.dart';
import 'package:shopping_app/features/profile/domain/repositories/user_repository.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

void main() {
  MockUserLocalDataSource mockUserLocalDataSource;
  UserRepositoryImpl userRepositoryImpl;

  setUp(() {
    mockUserLocalDataSource = MockUserLocalDataSource();
    userRepositoryImpl = UserRepositoryImpl(localDataSource: mockUserLocalDataSource);
  });

  group('getProduct', () {
    final User user = User.fromJson(jsonDecode(fixture('user.json')));
    final User _user = user;

    test('should return local data when the call to local data source is successful', () async {
      // arrange
      when(mockUserLocalDataSource.getUserInfo()).thenAnswer((_) async => user);
      // act
      final result = await userRepositoryImpl.getUserInfo();
      print(result);
      //assert
      verify(mockUserLocalDataSource.getUserInfo());
      expect(result, equals(Right(user)));
    });
  });
}
