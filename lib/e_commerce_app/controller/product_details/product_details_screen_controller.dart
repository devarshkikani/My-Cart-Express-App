import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  RxInt sliderValue = 0.obs;
  final CarouselController carouselController = CarouselController();
  final List<String> imgList = <String>[
    'https://img.freepik.com/free-psd/horizontal-banner-template-fashion-collection_23-2149039576.jpg',
    'https://img.freepik.com/free-psd/horizontal-banner-template-online-fashion-sale_23-2148585405.jpg',
    'https://img.freepik.com/free-psd/summer-collection-sale-banner-template_23-2148520737.jpg',
  ];

  List<Map<String, dynamic>> reviews = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'Avinash Kumar',
      'date': '25/06/2021',
      'rating': '5.0',
      'review':
          '''In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.''',
    },
    <String, dynamic>{
      'name': 'Pradip Chauhan',
      'date': '21/06/2021',
      'rating': '4.5',
      'review':
          '''I found that this product is easy to use and vey well finished. you will fill comfortable while holding this product in your hand.''',
    },
    <String, dynamic>{
      'name': 'Brijesh',
      'date': '12/05/2021',
      'rating': '4.2',
      'review':
          '''This product is realy nice I encourage all users to buy this product''',
    },
    <String, dynamic>{
      'name': 'Vivek',
      'date': '08/05/2021',
      'rating': '3.5',
      'review': '''This mobile is best suitable in this price.''',
    },
  ];
}
