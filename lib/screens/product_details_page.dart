
import 'package:e_kart/models/product.dart';
import 'package:e_kart/utils/bullted_text_items.dart';
import 'package:e_kart/utils/notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../res/colours.dart';
import '../res/strings.dart';
import 'app.dart';

class ProductDetailsPage extends StatefulWidget {
  // const ProductDetailsPage(Product productList, {Key? key}) : super(key: key);

  final Product product;

  ProductDetailsPage(this.product, {super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.pink
  ];
  var selectedColor = Colors.blue;
  final ProductController productController = Get.put(ProductController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            header(),
            hero(),
            Expanded(child: section()),
            bottomButton()
          ],
        ),
      ),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
        showAlertDialog(context, "Wanna open in app browser? ", widget.product.name, "Yes","INAPPWEB" ,widget.product.productLink!, true),
      },
        elevation: 20,
        backgroundColor: Colors.blue,
        mini: false,
        child: FaIcon(FontAwesomeIcons.chrome),
      ),
    );
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => App());
            },),
          Column(
            children: [
              const Text(Strings.appName,
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16)),
              Text(getProductShortName(widget.product.name),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
            ],
          ),
          IconButton(
            icon:  Icon(Icons.share_rounded),
            onPressed: () {
              showAlertDialog(context, "Wanna share this product ? ", widget.product.name, "Share in WhatsApp","WA" ,widget.product.productLink!, true);
            },),
        ],
      ),
    );
  }

  Widget hero() {
    return Container(
      child: Stack(
        children: [
          Image.network(
            widget.product.imageLink!,


          ),
          Positioned(
            top: 0,
            right: 0,

            child: Obx(() => CircleAvatar(
              backgroundColor: Colors.red[50],
              child: IconButton(
                icon: widget.product.isFavorite.value
                    ? Icon(Icons.favorite_rounded,
                    color: widget.product.isFavorite.value
                        ? Colors.redAccent
                        : null)
                    : const Icon(Icons.favorite_border,
                    color: Colors.redAccent),
                onPressed: () {
                  widget.product.isFavorite.toggle();
                  // Get.to(() => WishList());
                },
              ),
            )),
          )
        ],
      ),
    );
  }

  Widget section() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            property(),
            SizedBox(height: 20),
            Row(children: <Widget>[
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: const Divider(
                      color: Colors.grey,
                      height: 10,
                    )),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colours.boxColor.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: const Text("Product Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45, fontSize: 13 ),
                ),
              ),

              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                    )),
              ),
            ]),
            SizedBox(height: 20),
            Text(
              widget.product.name,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: const TextStyle(color: Colours.black, fontSize: 24, height: 1, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            UnorderedList(myFuc(widget.product.description.toString())),
            // Text(
            //   widget.product.description.toString().trim(),
            //   textAlign: TextAlign.justify,
            //   maxLines: 10,
            //   style:
            //       TextStyle(color: Colours.bodyColor, fontSize: 14, height: 1.5),
            // ),
          ],
        ),
      ),
    );
  }

  Widget property() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Color",
                  style: TextStyle(
                      color: Colours.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Row(
                children: List.generate(
                    4,
                    (index) => GestureDetector(
                          onTap: () {
                            print("index $index clicked");
                            setState(() {
                              selectedColor = colors[index];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(right: 10),
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.circular(17)),
                            child: selectedColor == colors[index]
                                ? const Icon(Icons.check_rounded,color: Colours.black,)
                                : const SizedBox(),
                          ),
                        )),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Rating",
                  style: TextStyle(
                      color: Colours.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              if (widget.product.rating != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.product.rating.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ) else Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "NA",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.star_purple500_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

            ],
          )
        ],
      ),
    );
  }

  Widget bottomButton() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      color: Colours.boxColor.withOpacity(0.10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Add to eKart +",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
          ),
          Text("\u{20B9} ${widget.product.price}",
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 35))
        ],
      ),
    );
  }

  String getProductShortName(String productName) {
    var parts = productName.split(' ');
    var newParts = '${parts[1]} ${parts[2]}';
    return newParts.toString();
  }



}
