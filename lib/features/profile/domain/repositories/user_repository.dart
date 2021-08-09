import 'package:dartz/dartz.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUserInfo();
  Future<Either<Failure, bool>> addCart(int id);
  Future<Either<Failure, bool>> addFavorite(int id);
}
