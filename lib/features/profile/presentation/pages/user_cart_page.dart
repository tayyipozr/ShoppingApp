import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_cubit.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_state.dart';
import 'package:shopping_app/features/profile/presentation/widgets/user_cart_page_widgets/cart_item_shadow.dart';
import 'package:shopping_app/features/profile/presentation/widgets/user_cart_page_widgets/dismissable_cart_item.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

class UserCartPage extends StatefulWidget {
  const UserCartPage({Key key}) : super(key: key);

  @override
  _UserCartPageState createState() => _UserCartPageState();
}

class _UserCartPageState extends State<UserCartPage> {
  List<ProductModel> products;

  @override
  void initState() {
    products = List<ProductModel>();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await context.cubit<UserCubit>().getCart();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart")),
      body: CubitConsumer<UserCubit, UserState>(buildWhen: (previous, current) {
        return !(previous is UserCartDeleted);
      }, builder: (BuildContext context, UserState state) {
        if (state is UserCartLoading) {
          return CartItemShadow();
        } else if (state is UserGetCart) {
          products = state.cart;
          return _buildListView(state.cart);
        } else if (state is UserCartDeleted) {
          return _buildListView(products);
        } else {
          return SizedBox.shrink();
        }
      }, listener: (context, state) {
        if (state is UserError) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserCartDeleted) {
          if (state.isDeleted) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Product Deleted")));
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Couldn't Deleted")));
          }
        }
      }),
    );
  }

  ListView _buildListView(List<ProductModel> cart) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: cart.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == cart.length) {
          if(index != 0) {
            double total = 0.0;
            cart.forEach((element) => total += element.price);
            return _buildTotalPrice(total);
          } else {
            return SizedBox.shrink();
          }
        } else {
          ProductModel productModel = cart[index];
          return DismissibleCartItem(
              productModel: productModel,
              uniqueKey: productModel.toString(),
              removeItem: () async {
                final isDeleted = await context.cubit<UserCubit>().deleteCart(productModel);
                products.remove(productModel);
                if(!isDeleted){
                  products.add(productModel);
                }
              });
        }
      },
    );
  }

  Row _buildTotalPrice(double total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Total Price : "),
        Text(
          "\$" + total.toStringAsFixed(2),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
