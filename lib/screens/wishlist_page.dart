import 'package:flutter/material.dart';

import '../models/product.dart';


class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish List'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const ListTile(
          title: Text("1"),
        ),
      ),
    );
  }
}
