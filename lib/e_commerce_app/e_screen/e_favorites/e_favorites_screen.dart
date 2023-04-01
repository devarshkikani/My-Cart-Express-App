import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_divider.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_favorites/e_favorites_screen_controller.dart';

class EFavoritesScreen extends StatelessWidget {
  const EFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Favorites',
        ),
      ),
      body: SizedBox(
        height: Get.height,
        child: GetBuilder<EFavoritesScreenController>(
          init: EFavoritesScreenController(),
          builder: (_) => Column(
            children: <Widget>[
              dividers(0),
              Expanded(
                child: _.favoritesList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 250,
                              width: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite,
                                size: 180,
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                            height30,
                            const Text(
                              'No Products In Favourite List!',
                              style: mediumText22,
                            ),
                            height30,
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: favoritesList(context, _),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget favoritesList(BuildContext context, EFavoritesScreenController _) {
    return ListView.builder(
      itemCount: _.favoritesList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      itemBuilder: (BuildContext context, int index) =>
          cartDecoration(context, _, index),
    );
  }

  Widget cartDecoration(
      BuildContext context, EFavoritesScreenController _, int index) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Get.find<ThemeController>().isDarkTheme.value
            ? Theme.of(context).colorScheme.tertiary.withOpacity(0.5)
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: Get.find<ThemeController>().isDarkTheme.value
            ? <BoxShadow>[]
            : <BoxShadow>[
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      _.favoritesList[index]['image'] as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                width10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      height5,
                      Text(
                        _.favoritesList[index]['title'] as String,
                        style: regularText14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      height5,
                      Text(
                        '''\$${_.favoritesList[index]['discount_price']}''',
                        style: regularText16,
                      ),
                      height5,
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '''\$${_.favoritesList[index]['real_price']}''',
                              style: lightText12.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '''  ${_.favoritesList[index]['discount']}% off''',
                              style: lightText12.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                width5,
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.delete_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            dividers(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'ADD TO CART',
                    style: regularText16.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
