import 'package:e_kart/screens/product_details_page.dart';
import 'package:e_kart/utils/notifier.dart';
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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                Strings.titleMakeUpKit,
                style: TextStyle(
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
                return Container(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: productController.productList.length,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    itemBuilder: (context, index) => GestureDetector (
                      onTap: () {

                        Get.to(() => ProductDetailsPage(
                          productController.productList[index]
                        ));
                        // showSnackBar(context, productController.productList[index].name);

                        },
                      child: ProductTile(productController.productList[index]),
                    ),
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
