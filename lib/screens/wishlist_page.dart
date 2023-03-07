import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/product_controller.dart';
import '../models/product.dart';
import '../res/log.dart';


class Wishlist extends StatefulWidget {
  Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<Product> myNewStringList = [];


  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final List<String> texts;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish List'),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: productController.productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xff764abc),
                    child: Image.network(getImage(productController, index)),
                  ),
                  title: Text(getTitle(productController, index)),
                  subtitle: Text(getDesc(productController, index),
                    maxLines: 2,),
                ),
              );
            },
          )
      ),
    );
  }


  String getImage(ProductController productController, int index) {
    if(productController.productList[index].isFavorite.value) {
      return productController.productList[index].imageLink;
    }else {
      return "";
    }
  }

  String getTitle(ProductController productController, int index) {
    if(productController.productList[index].isFavorite.value) {
      return productController.productList[index].name;
    }else {
      return "";
    }
  }

  String getDesc(ProductController productController, int index) {
    if(productController.productList[index].isFavorite.value) {
      return productController.productList[index].description.toString();
    }else {
      return "";
    }
  }




}
