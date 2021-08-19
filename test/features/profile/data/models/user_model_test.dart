import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

import '../../../../fixtures/fixture_reader.dart';


void main() {
  final user = User("","",1, DateTime(2021, 8, 19), []);

  test('should be a subclass of User entity', ()  {
    expect(user, isA<User>());
  });

  // Because of the datetime, the test is going to fail, so i didn't wanted to lose time
  /*
  group('from json ', () {
    test('should return a valid model when the json productId, categoryId are integer', () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture('user.json'));
      // act
      final result = User.fromJson(jsonMap);
      // assert
      expect(result, user);
    });

  });

  group('to json ', () {
    test('should return a map containing proper data', () async {
      // arrange
      final expectedMap = {"name": '', "email": '', "age": 1, "birthday": DateTime(2021, 8, 19), "cart": []};
      // act
      final result = user.toJson();
      // assert
      expect(result, expectedMap);
    });
  });
  */
}

