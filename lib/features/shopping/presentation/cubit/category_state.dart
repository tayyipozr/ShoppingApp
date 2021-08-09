import 'package:meta/meta.dart';

@immutable
abstract class CategoryState {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

class CategoriesLoaded extends CategoryState {
  final List<String> categories;

  const CategoriesLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);
}
