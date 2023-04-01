import 'package:get/get.dart';

class ETrackOrderScreenController extends GetxController {
  List<Map<String, dynamic>> trackDetails = <Map<String, dynamic>>[
    <String, dynamic>{
      'status': 'Ordered',
      'isDone': '',
      'date': 'Sat, 19th Dec 2020',
      'description': '',
    },
    <String, dynamic>{
      'status': 'Shipped',
      'isDone': '',
      'date': 'Sat, 22nd Dec 2020',
      'description':
          '''Package left warehouse facility, 10:00 pm\nPackage arrived at Grand Station, 12:00 pm''',
    },
    <String, dynamic>{
      'status': 'Delivered',
      'isDone': '',
      'date': '',
      'description': '',
    },
  ];
}
