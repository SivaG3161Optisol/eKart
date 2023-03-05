import 'package:e_kart/res/strings.dart';
import 'package:e_kart/screens/shipping_fragment.dart';
import 'package:e_kart/screens/wishlist_page.dart';
import 'package:e_kart/utils/notifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_kart/controllers/product_controller.dart';
import 'package:e_kart/widgets/product_tile.dart';
import '../blocs/counter_bloc.dart';
import '../models/product.dart';
import '../res/colours.dart';
import '../res/dimens.dart';
import '../res/log.dart';
import '../widgets/custom_alert_dialog.dart';
import 'account_fragment.dart';
import 'home_fragment.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final ProductController productController = Get.put(ProductController());
  final counterBloc = CounterBloc();
  final _wished = <Product>{};
  late final Product product;


  // Bottom bar
  final List<BottomNavigationBarItem> _navigationItems = <BottomNavigationBarItem>[];
  int _navigationIndex = 0;
  String _value = "";

  //list of widgets to call ontap
  final widgetOptions = [
    const HomeFragment(),
    const ShippingFragment(),
    const AccountFragment(),
  ];

  final widgetTitle = [Strings.homePage, Strings.shippingPage, Strings.accountPage];


  @override
  void initState() {
    _navigationItems.add(
        const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: Strings.titleHome));
    _navigationItems.add(
        const BottomNavigationBarItem(icon: Icon(Icons.local_shipping_outlined), label: Strings.titleShipping));
    _navigationItems.add(const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined), label: Strings.titleAccount));
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'eKart',
          style: TextStyle(
              fontFamily: 'avenir', fontSize: 32, fontWeight: FontWeight.w900),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_outline_rounded,
            ),
            onPressed: () {
              _routeToPage(Strings.wishlistPage);
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
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: widgetOptions.elementAt(_navigationIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        fixedColor: Colors.blue,
        currentIndex: _navigationIndex,
        onTap: (int item) {
          setState(() {
            _navigationIndex = item;

            _value = "Clicked on $_navigationIndex no index";
            Log.i("selected nav item $_value");
          });
        },
      ),
      persistentFooterButtons: [
        IconButton(
            onPressed: () => _onPressed("List view triggered"),
            icon: const Icon(Icons.view_list_rounded)),
        IconButton(
            onPressed: () => _onPressed("Grid view triggered"),
            icon: const Icon(Icons.grid_view)),
      ],
    );
  }

  void _routeToPage(String pageName) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (context) {
            if (pageName == Strings.wishlistPage) {
              return  WishList();
            }else {
              return  App();
            }

          }
      ),
    );
  }

  void _onPressed(String value) {
    setState(() {
      _value = value;
      showSnackBar(context, _value);
      showAlertDialog(context, "title", "desc", "Continue","","", true);
    });
  }



}
