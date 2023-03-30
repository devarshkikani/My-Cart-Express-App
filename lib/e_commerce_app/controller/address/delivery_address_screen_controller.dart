import 'package:get/get.dart';

class DeliveryAddressScreenController extends GetxController {
  List<Map<String, dynamic>> addressList = <Map<String, dynamic>>[
    <String, String>{
      'title': 'Home Address',
      'address1': '2249 Carling Ave #416',
      'address2': 'Ottawa, ON K2B 7E9',
      'country': 'Canada',
    },
    <String, String>{
      'title': 'Billing Address',
      'address1': '4153 Rosewood lane',
      'address2': 'Toronto, M4P 1A6',
      'country': 'Canada',
    },
  ];
}
