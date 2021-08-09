import 'package:dartz/dartz.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';

class GetProductsByCategories implements UseCase<List<ProductModel>, NameParams> {
  final ProductRepository productRepository;

  GetProductsByCategories(this.productRepository);

  @override
  Future<Either<Failure, List<ProductModel>>> call(NameParams params) async {
    return await productRepository.getProductsByCategory(params.name);
  }
}

