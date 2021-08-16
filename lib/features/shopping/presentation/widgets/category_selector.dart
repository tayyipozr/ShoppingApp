import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/product_cubit.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key key,
    this.categories,
  }) : super(key: key);

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length + 1,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                index == 4
                    ? context.cubit<ProductCubit>().getProducts()
                    : context.cubit<ProductCubit>().filterProductsByCategories(categories[index]);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: index == 4 ? Text("All") : Text(categories[index]),
                ),
                color: Colors.grey,
                elevation: 10,
              ),
            ),
          ),
        ).reversed.toList(),
      ),
    );
  }
}
