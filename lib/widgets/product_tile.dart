import 'package:e_kart/screens/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_kart/models/product.dart';

import '../blocs/counter_bloc.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final counterBloc = CounterBloc();
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    product.imageLink,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Obx(() => CircleAvatar(
                    backgroundColor: Colors.red[50],
                    child: IconButton(
                      icon: product.isFavorite.value
                          ? Icon(Icons.favorite_rounded,
                          color: product.isFavorite.value
                              ? Colors.redAccent
                              : null)
                          : const Icon(Icons.favorite_border,
                          color: Colors.redAccent),
                      onPressed: () {
                        product.isFavorite.toggle();
                      },
                    ),
                  )),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 2,
              style: TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            if (product.rating != null)
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.rating.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text('\$${product.price}',
                style: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'avenir',
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {
                            counterBloc.eventSink.add(CounterAction.Decrement);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red[400],
                            ),
                          )),
                      StreamBuilder(
                        stream: counterBloc.counterStream,
                        initialData: 0,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              '${snapshot.data}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          );
                        },
                      ),
                      InkWell(
                          onTap: () {
                            counterBloc.eventSink.add(CounterAction.Increment);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.green[500],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
