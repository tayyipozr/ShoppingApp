import 'package:dartz/dartz.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/profile/domain/repositories/user_repository.dart';


class GetUserInfo implements UseCase<User, NoParams> {
  final UserRepository _userRepository;

  GetUserInfo(this._userRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await _userRepository.getUserInfo();
  }
}

