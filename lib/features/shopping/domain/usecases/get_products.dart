import 'package:dartz/dartz.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';

class GetProducts implements UseCase<List<ProductModel>, NoParams> {
  final ProductRepository productRepository;

  GetProducts(this.productRepository);

  @override
  Future<Either<Failure, List<ProductModel>>> call(NoParams noParams) async {
    return await productRepository.getProducts();
  }
}

