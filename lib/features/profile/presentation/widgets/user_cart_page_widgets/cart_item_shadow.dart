import 'package:flutter/material.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

class CartItemShadow extends StatelessWidget {
  const CartItemShadow({
    Key key, this.length,
  }) : super(key: key);

  final int length;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Opacity(
          opacity: 0.2,
          child: Container(
            color: Colors.grey,
            height: 80,
          ),
        ),
      ),
    );
  }
}
