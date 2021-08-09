import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_cubit.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_state.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

class UserCartPage extends StatefulWidget {
  const UserCartPage({Key key}) : super(key: key);

  @override
  _UserCartPageState createState() => _UserCartPageState();
}

class _UserCartPageState extends State<UserCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart")),
      body: CubitConsumer<UserCubit, UserState>(
          builder: (BuildContext context, UserState state) {
            if (state is UserGetCart) {
              return GridView.builder(
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5, childAspectRatio: 0.45),
                itemCount: state.cart.length,
                itemBuilder: (BuildContext context, int index) {
                  ProductModel productModel = state.cart[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: 200,
                            height: 180,
                            child: Image.network(productModel.image, fit: BoxFit.contain)),
                        Text(
                          productModel.title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          '\$' + productModel.price.toString(),
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return SizedBox.shrink();
            }
          },
          listener: (context, state) {}),
    );
  }
}
