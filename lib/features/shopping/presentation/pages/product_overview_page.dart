import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_cart.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_cubit.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_state.dart';
import 'package:shopping_app/features/profile/presentation/pages/user_cart_page.dart';
import 'package:shopping_app/features/profile/presentation/pages/user_profile_page.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/category_cubit.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/category_state.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/product_cubit.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/product_state.dart';
import 'package:shopping_app/features/shopping/presentation/pages/product_detail_page.dart';

// TODO While getting data show shades not circular progress

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({Key key}) : super(key: key);

  @override
  _ProductOverviewPageState createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  @override
  void didChangeDependencies() async {
    await context.cubit<ProductCubit>().getProducts();
    await context.cubit<CategoryCubit>().getCategories();
    await context.cubit<UserCubit>().getCart();

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          CubitConsumer<CategoryCubit, CategoryState>(
            listener: (context, state) {
              if (state is CategoryError) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("HERE")));
              }
            },
            builder: (BuildContext context, CategoryState state) {
              if (state is CategoryInitial) {
                return _buildCategoryScrollViewShade();
              } else if (state is CategoryLoading) {
                return _buildCategoryScrollViewShade();
              } else if (state is CategoriesLoaded) {
                return _buildCategoryScrollView(state);
              } else {
                return _buildError();
              }
            },
          ),
          CubitConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
              if (state is ProductError) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("HERE")));
              }
            },
            builder: (BuildContext context, ProductState state) {
              if (state is ProductInitial) {
                return _buildProgressIndicator();
              } else if (state is ProductLoading) {
                return _buildGridViewProductsShade();
              } else if (state is ProductsLoaded) {
                return _buildGridViewProducts(state);
              } else {
                return _buildError();
              }
            },
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _buildCategoryScrollView(CategoriesLoaded state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          state.categories.length + 1,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                index == 4
                    ? context.cubit<ProductCubit>().getProducts()
                    : context.cubit<ProductCubit>().filterProductsByCategories(state.categories[index]);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: index == 4 ? Text("All") : Text(state.categories[index]),
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

  SingleChildScrollView _buildCategoryScrollViewShade() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) => Opacity(
            opacity: 0.2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 70,
                height: 30,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center _buildError() => Center(child: Text("Error"));

  Expanded _buildGridViewProductsShade() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.5),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Opacity(
            opacity: 0.2,
            child: Container(
              height: 250,
              width: 200,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

  Expanded _buildGridViewProducts(ProductsLoaded state) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.5),
        itemCount: state.products.length,
        itemBuilder: (BuildContext context, int index) {
          ProductModel productModel = state.products[index];
          return InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) {
                return CubitProvider.value(
                  value: CubitProvider.of<ProductCubit>(context),
                  child: ProductDetailPage(productModel: productModel),
                );
              }),
            ),
            child: Card(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: productModel.image,
                          child: Image.network(productModel.image, fit: BoxFit.contain),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              context.cubit<UserCubit>().addFavorite(productModel);
                            },
                            icon: Icon(Icons.favorite),
                            color: productModel.favorite ? Colors.orange : Colors.white,
                          ),
                          backgroundColor: Colors.orangeAccent[100],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              productModel.title,
                              style: TextStyle(fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            height: 30,
                          ),
                          Text(
                            '\$' + productModel.price.toString(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              color: Colors.blue,
                              onPressed: () async {
                                await context.cubit<UserCubit>().addCart(productModel);
                                await context.cubit<UserCubit>().getCart();
                              },
                              child: Text("Add to "
                                  "cart"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Center _buildProgressIndicator() => Center(child: CircularProgressIndicator());

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Shopping App'),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return CubitProvider.value(
                      value: CubitProvider.of<UserCubit>(context),
                      child: UserCartPage(),
                    );
                  }),
                );
              },
              icon: Icon(Icons.shopping_cart_outlined),
            ),
            CubitConsumer<UserCubit, UserState>(
              listener: (context, state){
              },
              builder:(BuildContext context, UserState state) {
                if (state is UserGetCart) {
                  return Positioned(
                    top: 7,
                    right: 7,
                    child: Stack(
                      children: [
                        Icon(
                          Icons.brightness_1,
                          size: 15,
                        ),
                        Positioned(
                          left: 4,
                          top: 0,
                          child: Center(
                              child: Text(
                            state.cart.length.toString(),
                            style: TextStyle(color: Colors.black),
                          )),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return CubitProvider.value(
                  value: CubitProvider.of<UserCubit>(context),
                  child: UserProfilePage(),
                );
              }));
            })
      ],
    );
  }
}
