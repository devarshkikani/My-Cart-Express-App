import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:badges/badges.dart' as b;
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_colors.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/e_theme/e_app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_input_text_field.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/e_small_product_view.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_home/e_home_controller.dart';

class EHomePage extends StatelessWidget {
  const EHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        child: GetBuilder<EHomeController>(
          init: EHomeController(),
          builder: (_) => Column(
            children: <Widget>[
              topView(context),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      height15,
                      silderView(context, _),
                      categoryView(context, _),
                      bestSellerView(context, _),
                      height20,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                width15,
                Expanded(
                  child: TextFormFieldWidget(
                    filledColor: Theme.of(context).colorScheme.background,
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: const BorderSide(
                      color: Colors.transparent,
                    ),
                    focusBorder: const BorderSide(
                      color: Colors.transparent,
                    ),
                    enabledBorder: const BorderSide(
                      color: Colors.transparent,
                    ),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Get.toNamed(ERoutes.search)?.then((_) {
                        FocusScope.of(context).unfocus();
                      });
                    },
                  ),
                ),
                width15,
                GestureDetector(
                  onTap: () {
                    Get.toNamed(ERoutes.notification);
                  },
                  child: b.Badge(
                    badgeContent: const Text(
                      '5',
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                width15,
                GestureDetector(
                  onTap: () {
                    Get.toNamed(ERoutes.cart);
                  },
                  child: b.Badge(
                    badgeContent: const Text(
                      '3',
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                width15,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget silderView(BuildContext context, EHomeController _) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 150,
          width: Get.width,
          child: CarouselSlider(
            carouselController: _.carouselController,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                _.sliderValue.value = index;
              },
            ),
            disableGesture: true,
            items: _.imgList
                .map(
                  (String item) => InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                        child: SizedBox(
                          width: Get.width,
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              _.imgList.asMap().entries.map((MapEntry<int, String> entry) {
            return GestureDetector(
              onTap: () => _.carouselController.animateToPage(entry.key),
              child: Obx(
                () => Container(
                  width: 8,
                  height: 8,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _.sliderValue.value == entry.key
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget categoryView(BuildContext context, EHomeController _) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Category',
                style: regularText16,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View all',
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            itemCount: _.categoryList.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => Container(
              width: 100,
              margin: EdgeInsets.only(
                left: index == 0 ? 15 : 0,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: Get.find<ThemeController>().isDarkTheme.value
                    ? Theme.of(context).colorScheme.tertiary.withOpacity(0.5)
                    : Theme.of(context).colorScheme.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        _.categoryList[index]['image'] as String,
                        color: whiteColor,
                      ),
                    ),
                    height5,
                    Text(_.categoryList[index]['title'] as String),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bestSellerView(BuildContext context, EHomeController _) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Best Seller',
                style: regularText16,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View all',
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 270,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              itemCount: _.bestSellerList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) =>
                  ESmallProductView(
                data: _.bestSellerList[index],
                width: 150,
                margin: EdgeInsets.only(
                  left: index == 0 ? 15 : 0,
                  right: 15,
                ),
                onTap: () {
                  Get.toNamed(ERoutes.productDetails);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
