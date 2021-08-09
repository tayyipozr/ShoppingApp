import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class User with _$User {
  const factory User(
      String name, String email, int age, DateTime birthday, List<ProductModel> favoriteProducts, List<ProductModel> cart) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
