import 'package:flutter/material.dart';
import 'package:shopping_app/core/extensions/context_extensions.dart';
import 'package:shopping_app/features/shopping/data/models/product_model/product_model.dart';

class DismissibleCartItem extends StatelessWidget {
  const DismissibleCartItem({
    Key key,
    @required this.productModel,
    @required this.uniqueKey,
    @required this.removeItem
  }) : super(key: key);

  final ProductModel productModel;
  final String uniqueKey;
  final VoidCallback removeItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(uniqueKey),
      child: ListTile(
        isThreeLine: true,
        leading: SizedBox(width: context.mediumValue ,child: Image.network(productModel.image, fit: BoxFit.fill)),
        title: Text(
          productModel.title,
          style: TextStyle(fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        subtitle: Text(
          '\$' + productModel.price.toString(),
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
      background: Container(
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: Padding(
            padding: context.paddingLow,
            child: Icon(Icons.delete),
          )),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        removeItem();
      },
    );
  }
}
