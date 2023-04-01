import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_address/e_add_new_address_screen_bindings.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_address/e_delivery_address_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_auth/e_sign_in_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_auth/e_sign_up_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_cart/e_cart_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_category/e_category_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_checkout/e_checkout_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_home/e_filter_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_home/e_home_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_home/e_notification_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_home/e_search_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_main_home/e_main_home_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_favorites/e_favorites_screen_bindings.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_payment/e_add_new_card_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_payment/e_payment_method_screen_bindings.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_product_details/e_product_details_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_profile/e_account_info_screen_bindings.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_profile/e_profile_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_splash_binding.dart';
import 'package:my_cart_express/e_commerce_app/e_binding/e_track_order/e_track_order_screen_bindings.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_address/e_add_new_address_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_address/e_delivery_address_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_auth/e_sign_in_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_auth/e_sign_up_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_cart/e_cart_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_category/e_category_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_checkout/checkout_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_home/e_filter_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_home/e_home_page.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_home/e_notification_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_home/e_search_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_main_home/e_main_home.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_favorites/e_favorites_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_onboarding/e_first_onboarding.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_order_success/e_order_success_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_payment/e_add_new_card_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_payment/e_payment_method_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_product_details/e_product_details.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_profile/e_account_info_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_profile/e_profile_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_splash_screen.dart';
import 'package:my_cart_express/e_commerce_app/e_screen/e_track_order/e_track_order_screen.dart';
part 'e_app_routes.dart';

class EAppPages {
  static final List<GetPage> pages = <GetPage>[
    GetPage(
      name: ERoutes.initial,
      page: () => const SplashScreen(),
      binding: ESplashScreenBinding(),
    ),
    GetPage(
      name: ERoutes.firstOnboarding,
      page: () => const FirstOnboarding(),
    ),
    GetPage(
      name: ERoutes.signIn,
      page: () => const ESignInScreen(),
      binding: ESignInBinding(),
    ),
    GetPage(
      name: ERoutes.signUp,
      page: () => const ESignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: ERoutes.mainHome,
      page: () => const EMainHome(),
      binding: EMainHomeBinding(),
    ),
    GetPage(
      name: ERoutes.home,
      page: () => const EHomePage(),
      binding: EHomeBinding(),
    ),
    GetPage(
      name: ERoutes.category,
      page: () => const ECategoryScreen(),
      binding: ECategoryScreenBinding(),
    ),
    GetPage(
      name: ERoutes.favorites,
      page: () => const EFavoritesScreen(),
      binding: EFavoritesScreenBinding(),
    ),
    GetPage(
      name: ERoutes.cart,
      page: () => const ECartScreen(),
      binding: ECartScreenBinding(),
    ),
    GetPage(
      name: ERoutes.profile,
      page: () => const EProfileScreen(),
      binding: EProfileScreenBinding(),
    ),
    GetPage(
      name: ERoutes.productDetails,
      page: () => const EProductDetailsScreen(),
      binding: EProductDetailsBinding(),
    ),
    GetPage(
      name: ERoutes.checkout,
      page: () => const ECheckoutScreen(),
      binding: ECheckoutScreenBinding(),
    ),
    GetPage(
      name: ERoutes.deliveryAddress,
      page: () => const EDeliveryAddressScreen(),
      binding: EDeliveryAddressScreenBinding(),
    ),
    GetPage(
      name: ERoutes.addNewAddress,
      page: () => const EAddNewAddressScreen(),
      binding: EAddNewAddressBinding(),
    ),
    GetPage(
      name: ERoutes.paymentMethod,
      page: () => const EPaymentMethodScreen(),
      binding: EPaymentMethosScreenBinding(),
    ),
    GetPage(
      name: ERoutes.addNewCardScreen,
      page: () => const EAddNewCardScreen(),
      binding: EAddNewCardScreenBinding(),
    ),
    GetPage(
      name: ERoutes.orderSuccess,
      page: () => const EOrderSuccessScreen(),
    ),
    GetPage(
      name: ERoutes.trackOrder,
      page: () => const ETrackOrderScreen(),
      binding: ETrackOrderScreenBinding(),
    ),
    GetPage(
      name: ERoutes.accountInfo,
      page: () => const EAccountInfoScreen(),
      binding: EAccountInfoScreenBinding(),
    ),
    GetPage(
      name: ERoutes.notification,
      page: () => const ENotificationScreen(),
      binding: ENotificationScreenBinding(),
    ),
    GetPage(
      name: ERoutes.search,
      page: () => const ESearchScreen(),
      binding: ESearchScreenBinding(),
    ),
    GetPage(
      name: ERoutes.filter,
      page: () => const EFilterScreen(),
      binding: EFilterScreenBinding(),
    ),
  ];
}
