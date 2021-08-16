import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:shopping_app/constants/navigation_constants.dart';
import 'package:shopping_app/features/profile/domain/usecases/add_cart.dart';
import 'package:shopping_app/features/profile/domain/usecases/delete_cart.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_cubit.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_state.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/category_cubit.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/category_state.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/product_cubit.dart';
import 'package:shopping_app/features/shopping/presentation/cubit/product_state.dart';
import 'package:shopping_app/features/shopping/presentation/widgets/category_selector.dart';
import 'package:shopping_app/features/shopping/presentation/widgets/category_selector_shade.dart';
import 'package:shopping_app/features/shopping/presentation/widgets/grid_view_products.dart';
import 'package:shopping_app/features/shopping/presentation/widgets/grid_view_shade.dart';

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
            builder: (BuildContext context, CategoryState state) {
              if (state is CategoryInitial) {
                return CategorySelectorShade();
              } else if (state is CategoryLoading) {
                return CategorySelectorShade();
              } else if (state is CategoriesLoaded) {
                return CategorySelector(categories: state.categories);
              } else {
                return _buildError();
              }
            },
            listener: (context, state) {
              if (state is CategoryError) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("HERE")));
              }
            },
          ),
          CubitConsumer<ProductCubit, ProductState>(
            builder: (BuildContext context, ProductState state) {
              if (state is ProductInitial) {
                return _buildProgressIndicator();
              } else if (state is ProductLoading) {
                return GridViewShade();
              } else if (state is ProductsLoaded) {
                return GridViewProducts(products: state.products);
              } else {
                return _buildError();
              }
            },
            listener: (context, state) {
              if (state is ProductError) {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("HERE")));
              }
            },
          ),
        ],
      ),
    );
  }

  Center _buildError() => Center(child: Text("Error"));

  Center _buildProgressIndicator() => Center(child: CircularProgressIndicator());

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Shopping App'),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            _shoppingCartIcon(),
            _shoppingCartCubit(),
          ],
        ),
        _buildUserProfileIcon()
      ],
    );
  }

  CubitConsumer<UserCubit, UserState> _shoppingCartCubit() {
    String i = "";
    return CubitConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if(state is UserCartAdded){
          if (state.isAdded) Scaffold.of(context).showSnackBar(SnackBar(content: Text("Product added to cart")));
          else Scaffold.of(context).showSnackBar(SnackBar(content: Text("Product couldn't added to cart")));
        }
      },
      builder: (BuildContext context, UserState state) {
        print(state);
        if (state is UserCartLoading) {
          return _shoppingCartItemCount(i);
        }
        if (state is UserGetCart) {
          i = state.cart.length.toString();
          return _shoppingCartItemCount(i);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Positioned _shoppingCartItemCount(String length) {
    return Positioned(
          top: 7,
          right: 7,
          child: Stack(
            children: [
              Icon(Icons.brightness_1, size: 15),
              Positioned(
                left: 4,
                top: 0,
                child: Center(
                    child: Text(
                  length,
                  style: TextStyle(color: Colors.black),
                )),
              ),
            ],
          ),
        );
  }

  IconButton _shoppingCartIcon() {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, NavigationConstants.USER_CART).then((value) async {
          await context.cubit<UserCubit>().getCart();
        });
      },
      icon: Icon(Icons.shopping_cart_outlined),
    );
  }

  IconButton _buildUserProfileIcon() {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        print("pressed");
        Navigator.pushNamed(context, NavigationConstants.USER_PROFILE);
      },
    );
  }
}
