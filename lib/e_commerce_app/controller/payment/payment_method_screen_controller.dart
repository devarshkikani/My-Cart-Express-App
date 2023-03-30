import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/constant/default_image.dart';

class PaymentMethodScreenController extends GetxController {
  List<Map<String, dynamic>> cardDetails = <Map<String, dynamic>>[
    <String, dynamic>{
      'code': '5678',
      'icon': masterCard,
      'default': true.obs,
    },
    <String, dynamic>{
      'code': '1234',
      'icon': visa,
      'default': false.obs,
    },
  ];

  List<String> walletList = <String>[
    gpayIcon,
    phonepeIcon,
    amazonPayIcon,
    upiIcon,
    gpayIcon,
    phonepeIcon,
    amazonPayIcon,
    upiIcon,
  ];
  List<String> netBanking = <String>[
    upiIcon,
    amazonPayIcon,
    phonepeIcon,
    gpayIcon,
  ];
}
