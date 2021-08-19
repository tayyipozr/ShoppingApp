import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/core/extensions/context_extensions.dart';
import 'package:shopping_app/features/profile/presentation/cubit/user_cubit.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel productModel;

  ProductDetailPage({@required this.productModel});

  @override
  Widget build(BuildContext context) {
    return productModel != null
        ? Scaffold(
            body: Stack(
              children: [
                Card(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildImage(context),
                        _buildContent(context),
                      ],
                    ),
                  ),
                ),
                _buildBackButton(context)
              ],
            ),
          )
        : SizedBox.shrink();
  }

  Padding _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\$" + productModel.price.toString(),
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Text(
              productModel.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(productModel.description),
          Align(
            alignment: Alignment.centerRight,
            child: _buildAddToCart(context, productModel),
          )
        ],
      ),
    );
  }

  Padding _buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Hero(
        tag: productModel.image,
        child: Image.network(productModel.image, fit: BoxFit.scaleDown, width: context.width / 1.7),
      ),
    );
  }

  Positioned _buildBackButton(BuildContext context) {
    return Positioned(
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_outlined)),
        left: 8,
        top: 30);
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
