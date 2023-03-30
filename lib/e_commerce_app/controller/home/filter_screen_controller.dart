import 'package:get/get.dart';

class FilterScreenController extends GetxController {
  RxString country = 'Brand'.obs;
  List<String> categoryList = <String>[
    'Home Decoration',
    'Mobiles',
    'Fashion',
    'Laptops',
    'Beauty Care',
    'Lifestyle',
  ];
  RxList<String> categorySelected = <String>[].obs;
}
