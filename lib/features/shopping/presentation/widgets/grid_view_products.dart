import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:shopping_app/constants/navigation_constants.dart';
import 'package:shopping_app/features/profile/data/models/user_model/user_model.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_cubit.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

class GridViewProducts extends StatelessWidget {
  const GridViewProducts({Key key, this.products}) : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.5),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          ProductModel productModel = products[index];
          return InkWell(
            child: Card(
              child: Column(
                children: [
                  _buildImageContainer(productModel),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: _buildProductTitle(productModel),
                            height: 30,
                          ),
                          _buildProductPrice(productModel),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _buildAddToCart(context, productModel),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.pushNamed(
              context,
              NavigationConstants.PRODUCT_DETAIL,
              arguments: products[index],
            ).then((value) {
              context.cubit<UserCubit>().getCart();
            }),
          );
        },
      ),
    );
  }

  Container _buildImageContainer(ProductModel productModel) {
    return Container(
      height: 200,
      width: 200,
      padding: const EdgeInsets.all(8.0),
      child: Hero(
        tag: productModel.image,
        child: Image.network(productModel.image, fit: BoxFit.contain),
      ),
    );
  }

  Text _buildProductTitle(ProductModel productModel) {
    return Text(
      productModel.title,
      style: TextStyle(fontWeight: FontWeight.w500),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Text _buildProductPrice(ProductModel productModel) {
    return Text(
      '\$' + productModel.price.toString(),
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  RaisedButton _buildAddToCart(BuildContext context, ProductModel productModel) {
    return RaisedButton(
      color: Colors.blue,
      onPressed: () async {
        await context.cubit<UserCubit>().addCart(productModel);
      },
      child: Text("Add to "
          "cart"),
    );
  }
}
