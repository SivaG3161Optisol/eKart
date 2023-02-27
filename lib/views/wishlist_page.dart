import 'package:flutter/material.dart';

import '../models/product.dart';


class WishList extends StatelessWidget {
  const WishList(int? id, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final Product product;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish List'),
      ),
      body: const ListTile(
        title: Text("1"),
      ),
    );
  }
}
