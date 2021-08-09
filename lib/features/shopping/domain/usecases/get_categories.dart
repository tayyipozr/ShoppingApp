import 'package:dartz/dartz.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';

class GetCategories implements UseCase<List<String>, NoParams> {

  final ProductRepository productRepository;

  GetCategories(this.productRepository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams noParams) async {
    return await productRepository.getCategories();
  }
  
}

