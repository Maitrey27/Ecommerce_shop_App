// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userproducts';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                //onpressed navigates us to new products screen were we can add new products
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  productsData.items[i].id,
                  productsData.items[i].title,
                  productsData.items[i].imageUrl,
                ),
                Divider(),
              ],
            ),
            itemCount: productsData.items.length,
          ),
        ),
      ),
    );
  }
}
