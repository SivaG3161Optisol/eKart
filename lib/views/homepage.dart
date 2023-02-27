import 'package:e_kart/models/product.dart';
import 'package:e_kart/views/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:e_kart/controllers/product_controller.dart';
import 'package:e_kart/widgets/product_tile.dart';

import '../counter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());
  final counterBloc = CounterBloc();
  final _wished = <Product>{};
  late final Product product;

  @override
  Widget build(BuildContext context) {
    bool _listViewState = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'eKart',
          style: TextStyle(
              fontFamily: 'avenir', fontSize: 32, fontWeight: FontWeight.w900),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_outline_rounded,
            ),
            onPressed: () {
              _goToWishListPage();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(Icons.view_list_rounded),
                    onPressed: () {

                    }),
                IconButton(
                    icon: const Icon(Icons.grid_view),
                    onPressed: () {
                      setState(() {
                        _listViewState = false;
                      });
                    }),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (_listViewState) {
                  return ListView.builder(itemBuilder: (context, index) {
                    return ProductTile(productController.productList[index]);
                  });
                } else {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: productController.productList.length,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return ProductTile(productController.productList[index]);
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  );
                }
              }
            }),
          )
        ],
      ),
    );
  }

  void _goToWishListPage() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return WishList();
        },
      ),
    );
  }
}
