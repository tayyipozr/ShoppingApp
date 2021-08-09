import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

part 'usecase.freezed.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

@freezed
abstract class Params with _$Params {
  const factory Params.id(int id) = IdParams;
  const factory Params.name(String name) = NameParams;
  const factory Params.product(ProductModel product) = ProductParams;
}

@freezed
abstract class NoParams with _$NoParams {
  const factory NoParams() = _NoParams;
}

