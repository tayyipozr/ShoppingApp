import 'package:dartz/dartz.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/profile/domain/repositories/user_repository.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';


class GetFavorites implements UseCase<List<ProductModel>, NoParams> {
  final UserRepository _userRepository;

  GetFavorites(this._userRepository);

  @override
  Future<Either<Failure, List<ProductModel>>> call(NoParams params) {
    return _userRepository.getFavorites();
  }
}

