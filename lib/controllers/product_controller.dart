import 'package:e_kart/utils/notifier.dart';
import 'package:get/state_manager.dart';
import 'package:e_kart/models/product.dart';
import 'package:e_kart/services/remote_services.dart';
import 'package:e_kart/res/log.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productList.value = products;
      }
    } on Exception catch (_, exp) {
      Log.e("$exp");
    } finally{
      isLoading(false);
    }
  }
}
