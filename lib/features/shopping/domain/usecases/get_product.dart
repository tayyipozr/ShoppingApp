import 'package:dartz/dartz.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';

class GetProduct implements UseCase<ProductModel, IdParams> {

  final ProductRepository productRepository;

  GetProduct(this.productRepository);

  @override
  Future<Either<Failure, ProductModel>> call(IdParams params) async {
   return await productRepository.getProduct(params.id);
  }
  
}

