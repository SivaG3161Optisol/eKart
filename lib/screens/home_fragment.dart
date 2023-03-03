

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/product_controller.dart';
import '../blocs/counter_bloc.dart';
import '../models/product.dart';
import '../res/colours.dart';
import '../res/dimens.dart';
import '../res/strings.dart';
import '../widgets/product_tile.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {


  final ProductController productController = Get.put(ProductController());
  final counterBloc = CounterBloc();
  final _wished = <Product>{};
  late final Product product;


  @override
  Widget build(BuildContext context) {
    bool _listViewState = false;

    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                Strings.titleMakeUpKit,
                style : TextStyle(
                  fontSize: Dimens.dp20,
                  fontWeight: FontWeight.bold,
                  color: Colours.black, //font color
                ),
              ),
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
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
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
}
