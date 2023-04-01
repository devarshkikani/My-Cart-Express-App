import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';

class ESmallProductView extends StatelessWidget {
  const ESmallProductView({
    super.key,
    required this.data,
    required this.onTap,
    this.margin,
    this.width,
  });
  final Map<String, dynamic> data;
  final Function() onTap;
  final EdgeInsets? margin;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            height: 250,
            margin: margin,
            decoration: BoxDecoration(
              color: Get.find<ThemeController>().isDarkTheme.value
                  ? Theme.of(context).colorScheme.tertiary.withOpacity(0.5)
                  : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
              boxShadow: Get.find<ThemeController>().isDarkTheme.value
                  ? <BoxShadow>[]
                  : <BoxShadow>[
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Container(
                    width: Get.width,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      data['image'] as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      height5,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          data['title'] as String,
                          style: regularText14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RatingBar.builder(
                          initialRating: data['rating'] as double,
                          minRating: 1,
                          allowHalfRating: true,
                          unratedColor: Colors.amber.withAlpha(50),
                          itemCount: 5,
                          itemSize: 15,
                          itemBuilder: (BuildContext context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          updateOnDrag: false,
                          ignoreGestures: true,
                          onRatingUpdate: (double value) {},
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '''\$${data['discount_price']}''',
                                    style: regularText16,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '''\$${data['real_price']}''',
                                          style: lightText12.copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '''  ${data['discount']}% off''',
                                          style: lightText12.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  height5,
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: whiteColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
