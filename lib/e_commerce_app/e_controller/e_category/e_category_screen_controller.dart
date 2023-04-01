import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_default_image.dart';

class ECategoryScreenController extends GetxController {
  List<Map<String, String>> categoryList = <Map<String, String>>[
    <String, String>{
      'title': 'Fashion',
      'image': dressIcon,
    },
    <String, String>{
      'title': 'Electronics',
      'image': electronics,
    },
    <String, String>{
      'title': 'Mobiles',
      'image': phone,
    },
    <String, String>{
      'title': 'Grocery',
      'image': grocery,
    },
    <String, String>{
      'title': 'Appliance',
      'image': appliances,
    },
    <String, String>{
      'title': 'Books',
      'image': bookIcon,
    },
    <String, String>{
      'title': 'Furniture',
      'image': sofaFurniture,
    },
    <String, String>{
      'title': 'Games',
      'image': games,
    },
    <String, String>{
      'title': 'Pet Products',
      'image': petProducts,
    },
    <String, String>{
      'title': 'Sports',
      'image': sports,
    },
    <String, String>{
      'title': 'Stationary',
      'image': stationaryIcon,
    },
    <String, String>{
      'title': 'Sunglasses',
      'image': sunglasses,
    },
  ];
}
