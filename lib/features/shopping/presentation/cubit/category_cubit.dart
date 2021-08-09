import 'package:shopping_app/core/error/failure.dart';
import 'package:shopping_app/core/usecases/usecase.dart';
import 'package:cubit/cubit.dart';
import 'package:shopping_app/features/shopping/domain/usecases/get_categories.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategories _getCategories;

  CategoryCubit(this._getCategories) : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());
    final response = await _getCategories(NoParams());
    response.fold((failure) {
      emit(CategoryError(failure is ServerFailure ? "Check your internet connection" : "An error occured"));
    }, (categories) {
      emit(CategoriesLoaded(categories));
    });
  }
}
