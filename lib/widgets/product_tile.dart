import 'package:e_kart/views/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_kart/models/product.dart';

import '../counter_bloc.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final counterBloc = CounterBloc();
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: product.isFavorite.value
                              ? Icon(Icons.favorite_rounded,
                                  color: product.isFavorite.value
                                      ? Colors.redAccent
                                      : null)
                              : Icon(Icons.favorite_border),
                          onPressed: () {
                            product.isFavorite.toggle();
                          },
                        ),
                      )),
                )
              ],
            ),
            SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 2,
              style:
                  TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 8),
            Text('\$${product.price}',
                style: TextStyle(fontSize: 32, fontFamily: 'avenir')),
            Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        counterBloc.eventSink.add(CounterAction.Decrement);
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
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
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${snapshot.data}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      );
                    },
                  ),
                  InkWell(
                      onTap: () {
                        counterBloc.eventSink.add(CounterAction.Increment);
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
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
      ),
    );
  }
}
