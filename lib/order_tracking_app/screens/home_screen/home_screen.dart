// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/widget/validator.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/widget/input_text_field.dart';
import 'package:my_cart_express/order_tracking_app/utils/dynamic_linking_service.dart';
import 'package:my_cart_express/order_tracking_app/screens/messages_screen/messages_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/shipping_screen/shipping_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/home_screen/home_screen_controller.dart';
import 'package:my_cart_express/order_tracking_app/screens/notification_screen/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      initState: (_) {},
      builder: (_) {
        _.getBalance(context);
        return Scaffold(
          body: Container(
            width: Get.height,
            color: primary,
            child: SafeArea(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    // leading: IconButton(
                    //   onPressed: () async {
                    //     await _.changeApp();
                    //   },
                    //   icon: const Icon(
                    //     Icons.change_circle_outlined,
                    //     color: whiteColor,
                    //   ),
                    // ),
                    centerTitle: true,
                    elevation: 0.0,
                    title: Text(
                      'MyCartExpress',
                      style: regularText20.copyWith(
                        color: whiteColor,
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const MessagesScreen());
                        },
                        child: const Icon(
                          Icons.mail_outline_rounded,
                          color: whiteColor,
                        ),
                      ),
                      width15,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const NotificationScreen());
                        },
                        child: const Icon(
                          Icons.notifications_active_outlined,
                          color: whiteColor,
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
                      child: bodyView(_, context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bodyView(HomeScreenController _, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => imageList.isNotEmpty
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider.builder(
                        itemCount: imageList.length,
                        carouselController: _.carouselController,
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          padEnds: true,
                          viewportFraction: 1.0,
                          height: 200,
                          autoPlay: imageList.length > 1,
                          scrollPhysics: imageList.length > 1
                              ? const AlwaysScrollableScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          autoPlayInterval: const Duration(seconds: 6),
                        ),
                        itemBuilder: (context, i, id) {
                          return InkWell(
                            onTap: () {
                              redirectHome(i);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  imageList[i]['image_url'],
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (imageList.length > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              height: 200,
                              width: 100,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _.carouselController.previousPage();
                                    },
                                    child: Image.asset(
                                      arrowLeft,
                                      height: 24,
                                      width: 24,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 100,
                              padding: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _.carouselController.nextPage();
                                    },
                                    child: Image.asset(
                                      arrowRight,
                                      height: 24,
                                      width: 24,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  )
                : const SizedBox(),
          ),
          Obx(() => imageList.isNotEmpty ? height15 : const SizedBox()),
          balanceView(_),
          height15,
          detailsView(_, context),
          height15,
          packagesView(_),
        ],
      ),
    );
  }

  Widget balanceView(HomeScreenController _) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        '\$${_.balance.value} JMD',
                        style: regularText18.copyWith(
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => _.mycartBucks.value == 0
                      ? const SizedBox()
                      : const VerticalDivider(
                          color: whiteColor,
                        ),
                ),
                Obx(
                  () => _.mycartBucks.value == 0
                      ? const SizedBox()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MyCart Bucks',
                              style: lightText14.copyWith(
                                color: whiteColor,
                              ),
                            ),
                            height5,
                            Text(
                              '\$${_.mycartBucks.value} ',
                              style: regularText18.copyWith(
                                color: whiteColor,
                              ),
                            ),
                          ],
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
          child: FutureBuilder<Uri>(
            future: DynamicRepository().createDynamicLink(
              GetStorage().read(StorageKey.userId) ?? '',
            ),
            builder: (context, snapshot) {
              Uri? uri = snapshot.data;
              return GestureDetector(
                onTap: () {
                  if (uri != null) {
                    Share.share(uri.toString());
                  } else {
                    NetworkDio.showError(
                      title: 'Error',
                      errorMessage:
                          'Something went wrong, please try again later',
                    );
                  }
                },
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
              );
            },
          ),
        ),
      ],
    );
  }

  Widget detailsView(HomeScreenController _, BuildContext context) {
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
                        style: lightText13.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Image.network(_.howItWorks.value),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(ctx);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: blackColor,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "How it's Work?",
                          style: lightText13.copyWith(
                            color: primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  height10,
                  Obx(
                    () => Text(
                      _.fullName.isNotEmpty ? _.fullName.value : '',
                      style: lightText13,
                    ),
                  ),
                  height10,
                  Obx(
                    () => Text(
                      _.usaShippingData.isNotEmpty
                          ? _.usaShippingData['address_1'] +
                              ' ' +
                              _.usaShippingData['address_2'] +
                              ' ' +
                              _.usaShippingData['city'] +
                              ', ' +
                              _.usaShippingData['state'] +
                              ', ' +
                              _.usaShippingData['postcode']
                          : '',
                      style: lightText13,
                    ),
                  ),
                  height10,
                  Obx(
                    () => Text(
                      'USA Tel: +1 ${_.usaShippingData.isNotEmpty ? _.usaShippingData['telephone'] : ''}',
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
                  Row(
                    children: [
                      Text(
                        'Pick-Up Branch',
                        style: regularText14,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await _.getBranch(context);
                                if (_.branchesList.isNotEmpty) {
                                  selectBranch(context, _);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: const Text(
                                  'Switch',
                                  style: TextStyle(
                                    letterSpacing: 0.5,
                                    color: whiteColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height5,
                  Obx(
                    () => Text(
                      _.pickuoBranchData.isNotEmpty
                          ? _.pickuoBranchData['location'] +
                              ' ' +
                              _.pickuoBranchData['address'] +
                              ' ' +
                              _.pickuoBranchData['city'] +
                              ', ' +
                              _.pickuoBranchData['parishname'] +
                              ', ' +
                              _.pickuoBranchData['code']
                          : '',
                      style: lightText13.copyWith(
                        color: primary,
                      ),
                    ),
                  ),
                  height10,
                  Obx(
                    () => Text(
                      _.pickuoBranchData.isNotEmpty
                          ? _.pickuoBranchData['open_hour']
                          : '',
                      style: lightText13.copyWith(
                        color: primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget packagesView(HomeScreenController _) {
    return Container(
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
          Obx(
            () => _.packagesList.isEmpty
                ? SizedBox(
                    height: 300,
                    child: Center(
                      child: Text(
                        'No packages found.',
                        style: lightText14.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: _.packagesList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        height10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 4,
                      ),
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
                                  _.packagesList[index]['shipping_mcecode'],
                                  style: lightText13.copyWith(
                                    color: blackColor,
                                  ),
                                ),
                                height10,
                                Text(
                                  _.packagesList[index]['tracking'],
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: _.packagesList[index]
                                              ['upload_attachment_flag'] ==
                                          1
                                      ? 20
                                      : 10),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            onPressed: _.packagesList[index]
                                        ['upload_attachment_flag'] ==
                                    1
                                ? () {
                                    uploadInvoice(
                                        _.packagesList[index]['package_id'],
                                        _,
                                        context);
                                  }
                                : null,
                            child: Row(
                              children: [
                                Text(
                                  _.packagesList[index]['invoice_type_label'],
                                  style: const TextStyle(
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                width10,
                                _.packagesList[index]
                                            ['upload_attachment_flag'] ==
                                        1
                                    ? Image.asset(
                                        addIcon,
                                        color: whiteColor,
                                        height: 14,
                                        width: 14,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void uploadInvoice(String packageId, HomeScreenController _, context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: offWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: uploadFileBodyView(packageId, _, context),
          );
        }).then((value) {
      _.declared.text = '';
      _.type.text = '';
      _.fileName.value = '';
      _.catId.value = '';
      _.selectedFile = null;
    });
  }

  Widget uploadFileBodyView(
      String packageId, HomeScreenController _, BuildContext context) {
    return Form(
      key: _.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Invoice',
                  style: regularText20,
                ),
              ],
            ),
            height20,
            Text(
              'Declared Value in USD',
              style: regularText14,
            ),
            height10,
            TextFormFieldWidget(
              hintText: 'Enter USD Value Here',
              controller: _.declared,
              validator: (value) =>
                  Validators.validateText(value, 'Declared Value in USD'),
            ),
            height20,
            Text(
              'Category',
              style: regularText14,
            ),
            height10,
            TextFormFieldWidget(
              hintText: 'Select category',
              controller: _.type,
              readOnly: true,
              onTap: () {
                showBottomSheet(
                  context,
                  1,
                  _,
                );
              },
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: primary,
              ),
              validator: (value) => Validators.validateText(value, 'File Type'),
            ),
            height15,
            Row(
              children: [
                Text(
                  'Attachment File',
                  style: lightText14,
                ),
              ],
            ),
            height15,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: greyColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Invoice file',
                        ),
                        Obx(() => Text(
                              _.fileName.value != ''
                                  ? _.fileName.value
                                  : '(filename.txt)',
                              style: lightText14.copyWith(
                                color: primary,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greyColor,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                          ),
                          onPressed: () async {
                            selectFileType(context, _);
                          },
                          child: const Text(
                            'Click to select file...',
                            style: TextStyle(
                              letterSpacing: 0.5,
                              color: primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            height20,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () async {
                if (_.formKey.currentState!.validate()) {
                  if (_.selectedFile != null) {
                    await _.submitOnTap(packageId, context);
                  } else {
                    NetworkDio.showError(
                      title: 'Warning',
                      errorMessage: 'Please select invoice first',
                    );
                  }
                }
              },
              child: const Text(
                'Upload Invoice',
                style: TextStyle(
                  letterSpacing: 0.5,
                ),
              ),
            ),
            height20,
          ],
        ),
      ),
    );
  }

  void selectFileType(BuildContext context, HomeScreenController _) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: offWhite,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                height20,
                ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'jpeg'],
                    );
                    await _.pickFile(result);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                    textStyle: const TextStyle(color: blackColor),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: blackColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "CHOOSE IMAGE FROM GALLERY",
                    style: TextStyle(
                      color: blackColor,
                    ),
                  ),
                ),
                height10,
                ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: [
                        'pdf',
                        'doc',
                      ],
                    );
                    await _.pickFile(result);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                    textStyle: const TextStyle(color: blackColor),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: blackColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "CHOOSE DOCUMENT",
                    style: TextStyle(
                      color: blackColor,
                    ),
                  ),
                ),
                height10,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blackColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                height20,
              ],
            ),
          ),
        );
      },
    );
  }

  void showBottomSheet(
      BuildContext context, int index, HomeScreenController _) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext ctx) {
        return SizedBox(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  magnification: 1.33,
                  squeeze: 1.2,
                  useMagnifier: true,
                  looping: true,
                  onSelectedItemChanged: (int i) {
                    _.type.text = _.categoriesList[i]['cat_name'];
                    _.catId.value = _.categoriesList[i]['id'];
                  },
                  children: List.generate(
                    _.categoriesList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _.categoriesList[index]['cat_name'],
                        style: mediumText18.copyWith(
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text(
                    'SELECT',
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              height10,
            ],
          ),
        );
      },
    );
  }

  void selectBranch(
    BuildContext context,
    HomeScreenController controller,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 40,
                    magnification: 1.20,
                    squeeze: 1.2,
                    useMagnifier: true,
                    looping: true,
                    onSelectedItemChanged: (int value) {
                      controller.selectedPickuoBranch.value =
                          controller.branchesList[value].toJson();
                      controller.branchId.value =
                          controller.branchesList[value].branchId ?? '0';
                    },
                    children: List.generate(
                      controller.branchesList.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              Text(
                                '${controller.branchesList[index].parishname} - ${controller.branchesList[index].code}',
                                style: mediumText14.copyWith(
                                  color: primary,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(Get.width, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await controller.updateBranch(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'SWITCH',
                      style: TextStyle(
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                height10,
              ],
            ),
          ),
        );
      },
    );
  }
}
