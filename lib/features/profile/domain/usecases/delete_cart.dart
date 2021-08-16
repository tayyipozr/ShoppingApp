import 'package:dartz/dartz.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/profile/domain/repositories/user_repository.dart';


class DeleteCart implements UseCase<bool, ProductParams> {

  final UserRepository _userRepository;

  DeleteCart(this._userRepository);

  @override
  Future<Either<Failure, bool>> call(ProductParams params) async {
    return await _userRepository.deleteCart(params.product);
  }

}

