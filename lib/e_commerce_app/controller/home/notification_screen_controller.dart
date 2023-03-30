import 'package:get/get.dart';

class NotificationScreenController extends GetxController {
  List<Map<String, dynamic>> notificationList = <Map<String, dynamic>>[
    <String, dynamic>{
      'image':
          'https://media.istockphoto.com/id/858568370/photo/water-droplet-on-glossy-surface-of-red-apple-on-black-background.jpg?s=612x612&w=0&k=20&c=TBpIe7RduwrorhX7zNfXJYWiEIgWqN2SVBLVa-Iuqao=',
      'title': 'Fresh collection of summer fruits for you',
      'date': '8h ago',
    },
    <String, dynamic>{
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA_QQX_Ioy-gMZSPx5SDBPRNJc481eqgtj2VP7AbPAs_cPHxAtsDR5t799V7tBWWEaz8A&usqp=CAU',
      'title': '30% Off in all dairy products',
      'date': '12h ago',
    },
    <String, dynamic>{
      'image':
          'https://i.insider.com/620fb33e462ff20019c5a66c?width=1000&format=jpeg&auto=webp',
      'title': 'your order has been shipped and out for delivery',
      'date': '20h ago',
    },
  ];
}
