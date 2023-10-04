import 'package:get/get.dart';
import 'package:promoter_tracking_app/services/db.dart';

class CartController extends GetxController {
  Rx<int> itemCount = 0.obs;
  Rx<double> totalPrice = 0.0.obs;

  void getItemCount() async {
    itemCount.value = await DatabaseHelper.getNumbersOfItems();
    update();
  }

  void getTotalPrice() async {
    var d = await DatabaseHelper.getTotalPrice();
    if (d != null) {
      totalPrice.value = d;
    } else {
      totalPrice.value = 0;
    }
    update();
  }
}
