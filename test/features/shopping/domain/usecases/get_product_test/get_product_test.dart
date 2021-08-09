import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:shopping_app/features/shopping/domain/entities/product.dart';
import 'package:shopping_app/features/shopping/domain/repositories/product_repository.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_product.dart';

/*
@GenerateMocks([ProductRepository])
void main() {
  var repository = MockProductRepository();
  var useCase = GetProduct(repository);

  final product = Product(productId: 1, categoryId: 1, productName: "Keyboard", price: 35.0, discount: 0);

  test(
    'should get product from the repository',
        () async {
      // arrange
      when(repository.getProduct(1)).thenAnswer((_) async => Right(product));
      // act
      final result = await useCase(Params(productId: 1));
      // assert
      expect(result, Right(product));
      verify(repository.getProduct(1));
      verifyNoMoreInteractions(repository);
    },
  );

}
*/
