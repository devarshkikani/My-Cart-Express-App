import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/app_endpoints.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/screens/messages_screen/messages_screen.dart';
import 'package:my_cart_express/screens/notification_screen/notifications_screen.dart';
import 'package:my_cart_express/screens/shipping_screen/shipping_screen.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/utils/network_dio.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RxInt balance = 0.obs;
  RxString howItWorks = ''.obs;
  RxMap pickuoBranchData = {}.obs;
  RxMap usaShippingData = {}.obs;
  RxList packagesList = [].obs;

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  void getBalance() async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.balance,
      context: context,
    );
    if (response != null) {
      balance.value = response['data'];
    }

    Map<String, dynamic>? packagesResponse = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.dashboardPackageList,
      context: context,
    );
    if (packagesResponse != null) {
      packagesList.value = packagesResponse['list'] ?? [];
    }

    Map<String, dynamic>? howItWorksResponse =
        await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.howItWorks,
      context: context,
    );
    if (howItWorksResponse != null) {
      howItWorks.value = howItWorksResponse['img_url'];
    }

    Map<String, dynamic>? shippingPickupAddress =
        await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingPickupAddress,
      context: context,
    );
    if (shippingPickupAddress != null) {
      usaShippingData.value = shippingPickupAddress['package_shipping_data']
          ['usa_air_address_details'];
      pickuoBranchData.value =
          shippingPickupAddress['package_shipping_data']['branch_data'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                leading: const SizedBox(),
                centerTitle: true,
                elevation: 0.0,
                title: const Text(
                  'MyCartExpress',
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const MessagesScreen());
                    },
                    child: const Icon(
                      Icons.mail_outline_rounded,
                    ),
                  ),
                  width15,
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const NotificationScreen());
                    },
                    child: const Icon(
                      Icons.notifications_active_outlined,
                    ),
                  ),
                  width15,
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 15,
                    right: 15,
                  ),
                  decoration: const BoxDecoration(
                    color: offWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: bodyView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyView() {
    return Column(
      children: [
        balanceView(),
        height15,
        detailsView(),
        height15,
        packagesView(),
      ],
    );
  }

  Widget balanceView() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'E-Wallet Balance',
                  style: lightText14.copyWith(
                    color: whiteColor,
                  ),
                ),
                height5,
                Obx(
                  () => Text(
                    '\$${balance.value} JMD',
                    style: regularText18.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Image.asset(
                  shareIcon,
                  height: 40,
                  width: 40,
                ),
                Text(
                  'Share this app',
                  style: lightText12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget detailsView() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'USA Shipping Address',
                    style: regularText14,
                  ),
                  height5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Air freight',
                        style: lightText14.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launchUrl(Uri.parse(howItWorks.value));
                        },
                        child: Text(
                          "How it's Work?",
                          style: lightText14.copyWith(
                            color: primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  height15,
                  Obx(
                    () => Text(
                      usaShippingData.isNotEmpty
                          ? usaShippingData['address_1'] +
                              ' ' +
                              usaShippingData['address_2'] +
                              ' ' +
                              usaShippingData['city'] +
                              ', ' +
                              usaShippingData['state'] +
                              ', ' +
                              usaShippingData['postcode']
                          : '',
                      style: lightText13,
                    ),
                  ),
                  height10,
                  Obx(
                    () => Text(
                      'USA Tel: +1 ${usaShippingData.isNotEmpty ? usaShippingData['telephone'] : ''}',
                      style: lightText13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pick-Up Branch',
                    style: regularText14,
                  ),
                  height15,
                  Obx(() => Text(
                        pickuoBranchData.isNotEmpty
                            ? pickuoBranchData['location'] +
                                ' ' +
                                pickuoBranchData['address'] +
                                ' ' +
                                pickuoBranchData['city'] +
                                ', ' +
                                pickuoBranchData['parishname'] +
                                ', ' +
                                pickuoBranchData['code']
                            : '',
                        style: lightText13.copyWith(
                          color: primary,
                        ),
                      )),
                  height10,
                  Obx(() => Text(
                        pickuoBranchData.isNotEmpty
                            ? pickuoBranchData['open_hour']
                            : '',
                        style: lightText13.copyWith(
                          color: primary,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget packagesView() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(
          left: 15,
          top: 15,
          right: 15,
        ),
        decoration: BoxDecoration(
          color: greyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Last 5 Packages',
                  style: regularText18,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const ShippingScreen(
                        isFromeHome: true,
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: lightText16,
                  ),
                ),
              ],
            ),
            height15,
            Expanded(
              child: Obx(
                () => packagesList.isEmpty
                    ? Center(
                        child: Image.asset(
                          emptyList,
                          height: 200,
                        ),
                      )
                    : ListView.separated(
                        itemCount: packagesList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            height10,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: greyColor,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      packagesList[index]['shipping_mcecode'],
                                      style: lightText13.copyWith(
                                        color: blackColor,
                                      ),
                                    ),
                                    height10,
                                    Text(
                                      packagesList[index]['tracking'],
                                      overflow: TextOverflow.ellipsis,
                                      style: lightText13.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: orangeColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    const Text(
                                      'Invoice Needed',
                                      style: TextStyle(
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    width10,
                                    Image.asset(
                                      addIcon,
                                      color: whiteColor,
                                      height: 14,
                                      width: 14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
