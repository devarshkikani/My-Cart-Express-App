// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:my_cart_express/e_commerce_app/e_constant/e_storage_key.dart';
import 'package:my_cart_express/e_commerce_app/e_controller/e_theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/e_routes/e_app_pages.dart';
import 'package:my_cart_express/e_commerce_app/e_widget/rating_bar/c_rating_bar.dart';
import 'package:my_cart_express/order_tracking_app/constant/default_images.dart';
import 'package:my_cart_express/order_tracking_app/constant/sizedbox.dart';
import 'package:my_cart_express/order_tracking_app/constant/storage_key.dart';
import 'package:my_cart_express/order_tracking_app/models/branches_model.dart';
import 'package:my_cart_express/order_tracking_app/screens/home/main_home_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/auth_pickup/auth_pickup_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/faqs_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/feedback_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/my_rewards_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/shipping_calculator_screen/shipping_calculator_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/support/support_index_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/more_screen/transaction_screen.dart';
import 'package:my_cart_express/order_tracking_app/screens/scanner_screen/scanner_screen.dart';
import 'package:my_cart_express/order_tracking_app/theme/colors.dart';
import 'package:my_cart_express/order_tracking_app/theme/text_style.dart';
import 'package:my_cart_express/order_tracking_app/utils/global_singleton.dart';
import 'package:my_cart_express/order_tracking_app/utils/network_dio.dart';
import 'package:my_cart_express/order_tracking_app/constant/app_endpoints.dart';
import 'package:my_cart_express/order_tracking_app/widget/location_permission_screen.dart';
import 'package:my_cart_express/order_tracking_app/widget/network_image_handle.dart';
import 'package:my_cart_express/order_tracking_app/widget/show_feedback_popup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

RxList imageList = [].obs;
RxString showLocation = ''.obs;

class HomeScreenController extends GetxController {
  Rx<File>? selectedFile;
  Rx<num> balance = Rx<num>(0);
  RxInt mycartBucks = 0.obs;
  RxString catId = ''.obs;
  RxString fileName = ''.obs;
  RxString fullName = ''.obs;
  RxString mce = ''.obs;
  RxString howItWorks = ''.obs;
  RxString videoTitle = ''.obs;
  RxString videoLink = ''.obs;
  RxInt countDown = 0.obs;
  RxBool isApiCalling = false.obs;
  RxList packagesList = [].obs;
  RxList categoriesList = [].obs;
  RxMap usaShippingData = {}.obs;
  RxMap pickuoBranchData = {}.obs;
  RxMap packageShippingData = {}.obs;
  GetStorage box = GetStorage();
  RxString branchId = ''.obs;
  RxMap selectedPickuoBranch = {}.obs;
  RxList<Branches> branchesList = <Branches>[].obs;
  RxInt categorySelectIndex = 0.obs;
  RxInt selectedPickuoBranchIndex = 0.obs;
  CarouselController carouselController = CarouselController();
  TextEditingController type = TextEditingController();
  TextEditingController declared = TextEditingController();
  late VideoPlayerController controller;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getBalance({
    required BuildContext context,
    String? id,
    String? staffFirstname,
    String? staffImage,
  }) async {
    if (showLocation.value == '1') {
      getCurrentPosition();
    }

    await updateAppVersionFunction(context);
    Map<String, dynamic>? shippingCount = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingCount,
      context: context,
    );
    if (shippingCount != null) {
      packageCounts.value = shippingCount['package_counts'];
      availablePackageCounts.value = shippingCount['available_package_counts'];
      overduePackageCounts.value = shippingCount['overdue_package_counts'];
      Map<String, dynamic>? packagesResponse =
          await NetworkDio.getDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.dashboardPackageList,
        context: context,
      );
      if (packagesResponse != null) {
        packagesList.value = packagesResponse['list'] ?? [];

        Map<String, dynamic>? howItWorksResponse =
            await NetworkDio.getDioHttpMethod(
          url: ApiEndPoints.apiEndPoint + ApiEndPoints.howItWorks,
          context: context,
        );
        if (howItWorksResponse != null) {
          howItWorks.value = howItWorksResponse['img_url'];
          Map<String, dynamic>? shippingPickupAddress =
              await NetworkDio.getDioHttpMethod(
            url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingPickupAddress,
            context: context,
          );
          if (shippingPickupAddress != null) {
            packageShippingData.value =
                shippingPickupAddress['package_shipping_data'];
            fullName.value = shippingPickupAddress['package_shipping_data']
                    ['firstname'] +
                ' ' +
                shippingPickupAddress['package_shipping_data']['lastname'];
            if (shippingPickupAddress['package_shipping_data']
                    ['usa_address_setting_details']['name_line'] ==
                '1') {
              fullName.value +=
                  ' ${shippingPickupAddress['package_shipping_data']['mce_number']}';
            }
            mce.value =
                shippingPickupAddress['package_shipping_data']['mce_number'];
            usaShippingData.value =
                shippingPickupAddress['package_shipping_data']
                    ['usa_air_address_details'];
            pickuoBranchData.value =
                shippingPickupAddress['package_shipping_data']['branch_data'];

            Map<String, dynamic>? categoriesListResponse =
                await NetworkDio.getDioHttpMethod(
              url: ApiEndPoints.apiEndPoint + ApiEndPoints.shippingCategories,
              context: context,
            );
            if (categoriesListResponse != null) {
              categoriesList.value = categoriesListResponse['list'];
              Map<String, dynamic>? response =
                  await NetworkDio.getDioHttpMethod(
                url: ApiEndPoints.apiEndPoint + ApiEndPoints.balance,
                context: context,
              );
              if (response != null) {
                balance.value = response['data']['ewallet_balance'];
                mycartBucks.value = response['data']['bucks_balance'];
                Map<String, dynamic>? images =
                    await NetworkDio.getDioHttpMethod(
                  url: ApiEndPoints.apiEndPoint +
                      ApiEndPoints.branchBannerImages,
                  context: context,
                );
                if (images != null) {
                  imageList.value = images['data'];
                }
              }
            }
          }
        }
      }
    }
    if (!isPopShown.value) {
      await getFeedbackNotAdded(
        context: context,
        id: id,
        staffFirstname: staffFirstname,
        staffImage: staffImage,
      );
    }
    await getUserDetails(context);
  }

  Future<void> updateAppVersionFunction(context) async {
    await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.updateAppVersion,
      data: dio.FormData.fromMap({
        'platform': Platform.isAndroid ? 'Android' : 'IOS',
        'app_version': GlobalSingleton.packageInfo?.version,
      }),
    );
  }

  Future<void> getUserDetails(context) async {
    if (GlobalSingleton.userDetails['show_rating_popup'] == 1) {
      final InAppReview inAppReview = InAppReview.instance;
      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
      }
    }
    if (GlobalSingleton.userDetails['is_app_rated'] == 0) {
      getBranchReviewDetailsCall(context);
    }
    if (GlobalSingleton.userDetails['show_unopened_support_message'] == 1) {
      showDialog(
        context: context,
        builder: (BuildContext ctttx) {
          return AlertDialog(
            content: const Text('You have an unread support message'),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: primary,
                ),
                child: const Text(
                  "Open",
                  style: TextStyle(color: whiteColor),
                ),
                onPressed: () async {
                  Navigator.pop(ctttx);
                  Get.to(() => const SupportIndexScreen());
                },
              ),
            ],
          );
        },
      );
    }
    if (GlobalSingleton.userDetails['show_splash_screen'] == 1) {
      await showSplashScreenVideo(context);
    }
  }

  Future<void> getFeedbackNotAdded({
    required BuildContext context,
    String? id,
    String? staffFirstname,
    String? staffImage,
  }) async {
    ShowFeedBackPopup feedBackPopup = ShowFeedBackPopup();
    if (id != null && staffFirstname != null && staffImage != null) {
      GetStorage box = GetStorage();
      if (box.read('showedPopup') != id) {
        print('FEEDBACK SHOW FROM NOTIFICATION');
        feedBackPopup.saveUserFeedbackPopup(
          id: id,
        );
        feedBackPopup.feedBackDialoag(
          context: context,
          id: id,
          staffName: staffFirstname,
          staffImage: staffImage,
        );
      }
    } else {
      print('FEEDBACK SHOW FROM APIS');
      await feedBackPopup.callApi(context: context);
    }
  }

  Future<void> getBranch(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.branches,
      context: context,
    );
    if (response != null) {
      for (var i = 0; i < response['data'].length; i++) {
        branchesList.add(Branches.fromJson(response['data'][i]));
      }
    }
  }

  Future<void> updateBranch(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.switchBranch,
      context: context,
      data: dio.FormData.fromMap({
        "branch_id": branchId.value,
      }),
    );
    if (response != null) {
      pickuoBranchData.value = selectedPickuoBranch.value;
      NetworkDio.showSuccess(
        title: 'Success',
        sucessMessage: response['message'],
      );
    }
  }

  Future<void> getCurrentPosition() async {
    final bool hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      return;
    }
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;
    } on Position catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> handleLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.to(() => const LocationPermissionScreen());
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.to(() => const LocationPermissionScreen());
      return false;
    }
    return true;
  }

  Future<void> pickFile(String path, String name) async {
    selectedFile = File(path).obs; //File(result.files.first.path!).obs;
    fileName.value = name; //result.files.first.name;
  }

  Future<void> submitOnTap(String? packageId, BuildContext context) async {
    final data = dio.FormData.fromMap({
      'files': await dio.MultipartFile.fromFile(
        selectedFile!.value.path,
        filename: fileName.value,
      ),
      'attachment_package_id': packageId,
      'attach_for': 'invoice',
      'customer_input_value': declared.text,
      'category_id': catId.value,
    });
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.uploadAttachments,
      data: data,
      context: context,
    );
    if (response != null) {
      Get.back();
      NetworkDio.showSuccess(
          title: 'Success', sucessMessage: response['message']);
      Map<String, dynamic>? packagesResponse =
          await NetworkDio.getDioHttpMethod(
        url: ApiEndPoints.apiEndPoint + ApiEndPoints.dashboardPackageList,
        context: context,
      );
      if (packagesResponse != null) {
        packagesList.value = packagesResponse['list'] ?? [];
      }
    }
  }

  Future<void> changeApp() async {
    Get.find<ThemeController>().isECommerce.value = true;
    box.write(StorageKey.isECommerce, true);
    if (box.read(EStorageKey.eIsLogedIn)) {
      Get.offAllNamed(ERoutes.mainHome);
    } else {
      Get.offAllNamed(ERoutes.firstOnboarding);
    }
  }

  Future<void> showSplashScreenVideo(context) async {
    Map<String, dynamic>? response = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.splashScreenVideo,
    );

    if (response != null) {
      videoLink.value = response['data']['splash_screen_video_url'];
      videoTitle.value = response['data']['title'];
      double? opacity = response['data']['splash_screen_video_opacity'];
      controller = VideoPlayerController.networkUrl(Uri.parse(videoLink.value))
        ..initialize().then((_) {
          controller.play();
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: blackColor.withOpacity(opacity ?? .8),
            builder: (BuildContext ctttx) {
              return dialogDesign(ctttx);
            },
          );
        });
      controller.addListener(() async {
        countDown.value = controller.value.duration.inSeconds -
            controller.value.position.inSeconds;
        if (controller.value.isCompleted) {
          controller.dispose();
          Get.back();
        }
        if (!isApiCalling.value) {
          isApiCalling.value = true;
          GlobalSingleton.userDetails['show_splash_screen'] = 0;
          await saveSplashScreenUserFunction(context);
        }
      });
    }
  }

  Widget dialogDesign(BuildContext ctttx) {
    return WillPopScope(
      onWillPop: () async {
        return isApiCalling.value;
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(18),
        content: Container(
          color: whiteColor,
          child: Stack(
            children: [
              Center(
                child: controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      )
                    : Container(),
              ),
              Container(
                height: 100,
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                width: Get.width,
                decoration: BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome to',
                      style: mediumText14,
                    ),
                    Image.asset(
                      appLogoColorfull,
                      height: 40,
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: Get.height * .4,
                  ),
                  child: Obx(
                    () => Text(
                      videoTitle.value,
                      style: mediumText16.copyWith(
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Obx(
                    () => Text(
                      'Countinue to dashbord in ${countDown.value} seconds',
                      style: mediumText16.copyWith(color: error),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveSplashScreenUserFunction(context) async {
    await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.saveSplashScreenUser,
      context: context,
      data: dio.FormData.fromMap({
        'user_id': GlobalSingleton.userDetails['userId'],
      }),
    );
  }

  Future<void> getBranchReviewDetailsCall(BuildContext context) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getBranchReviewDetails,
      context: context,
      data: dio.FormData.fromMap({
        'branch_id': GlobalSingleton.userDetails['branch_id'],
      }),
    );
    if (response != null) {
      if (response['data']['is_enable_google_review'] == '1') {
        showRatingPopUp(context, response['data']['google_review_link']);
      }
    }
  }

  void showRatingPopUp(BuildContext ctx, String googleReviewLink) {
    RxDouble ratingValue = 0.0.obs;
    showDialog(
      context: ctx,
      builder: (BuildContext ctttx) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Rate Your First Experience",
                  style:
                      TextStyle(color: blackColor, fontWeight: FontWeight.bold),
                ),
              ),
              height20,
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: GlobalSingleton.userDetails['image']
                                .toString()
                                .isEmpty ||
                            GlobalSingleton.userDetails['image'] == null
                        ? Image.asset(
                            dummyProfileImage,
                            height: 60,
                            width: 60,
                          )
                        : networkImage(
                            GlobalSingleton.userDetails['image'].toString(),
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                          ),
                  ),
                  width10,
                  Text(
                    '${GlobalSingleton.userDetails['name']}',
                  ),
                ],
              ),
              height10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    unratedColor: greyColor,
                    glow: false,
                    minRating: 1,
                    maxRating: 5,
                    initialRating: 0,
                    itemBuilder: (BuildContext context, int index) {
                      return const Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xFFFFD700),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                        ],
                      );
                    },
                    onRatingUpdate: (double rating) {
                      ratingValue.value = rating;
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: whiteColor,
                side: const BorderSide(
                  color: greyColor,
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(color: secondary),
              ),
              onPressed: () {
                Navigator.pop(ctttx);
              },
            ),
            Obx(
              () => TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: ratingValue.value == 0.0
                      ? secondary.withOpacity(0.1)
                      : secondary,
                ),
                onPressed: () async {
                  if (ratingValue.value != 0.0) {
                    await saveAppRating(
                      context: ctx,
                      rating: ratingValue.value,
                      link: googleReviewLink,
                    );
                    Navigator.pop(ctttx);
                  }
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                      color: ratingValue.value == 0.0 ? greyColor : whiteColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveAppRating(
      {required BuildContext context,
      required double rating,
      required String link}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.saveAppRating,
      context: context,
      data: dio.FormData.fromMap({
        'branch_id': GlobalSingleton.userDetails['branch_id'],
        'user_id': GlobalSingleton.userDetails['userId'],
        'rating': '$rating',
      }),
    );
    if (response != null) {
      if (rating == 5.0) {
        launchUrl(
          Uri.parse(link),
          mode: LaunchMode.externalApplication,
        );
      } else {
        NetworkDio.showSuccess(
          title: 'Success',
          sucessMessage: response['message'],
        );
      }
    }
  }
}

void redirectHome(int i) {
  bool isInAppRedirect = imageList[i]['image_link_type'] == "1";
  if (isInAppRedirect && imageList[i]['image_link'] == "1") {
    Get.to(const ShippingCalculatorScreen());
  } else if (isInAppRedirect && imageList[i]['image_link'] == "2") {
    Get.to(() => const TransactionScreen());
  } else if (isInAppRedirect && imageList[i]['image_link'] == "3") {
    Get.to(() => const FAQSScreen());
  } else if (isInAppRedirect && imageList[i]['image_link'] == "4") {
    Get.to(() => const SupportIndexScreen());
  } else if (isInAppRedirect && imageList[i]['image_link'] == "5") {
    Get.to(() => const FeedbackScreen());
  } else if (isInAppRedirect && imageList[i]['image_link'] == "6") {
    Get.to(() => const MyRewardsScreen());
  } else if (isInAppRedirect && imageList[i]['image_link'] == "7") {
    Get.to(() => const AuthPickUpScreen());
  } else if (imageList[i]['image_link_type'] == "2") {
    launchUrl(Uri.parse(imageList[i]['image_link']));
  }
}
