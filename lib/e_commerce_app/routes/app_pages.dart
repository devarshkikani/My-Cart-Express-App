import 'package:get/get.dart';
import 'package:my_cart_express/e_commerce_app/binding/address/add_new_address_screen_bindings.dart';
import 'package:my_cart_express/e_commerce_app/binding/address/delivery_address_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/auth/sign_in_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/auth/sign_up_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/cart/cart_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/category/category_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/checkout/checkout_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/home/filter_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/home/home_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/home/notification_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/home/search_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/main_home/main_home_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/favorites/favorites_screen_bindings.dart';
import 'package:my_cart_express/e_commerce_app/binding/payment/add_new_card_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/payment/payment_method_screen_bindings.dart';
import 'package:my_cart_express/e_commerce_app/binding/product_details/product_details_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/profile/account_info_screen_bindings.dart';
import 'package:my_cart_express/e_commerce_app/binding/profile/profile_screen_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/splash_binding.dart';
import 'package:my_cart_express/e_commerce_app/binding/track_order/track_order_screen_bindings.dart';
import 'package:my_cart_express/e_commerce_app/screen/address/add_new_address_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/address/delivery_address_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/auth/sign_in_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/auth/sign_up_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/cart/cart_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/category/category_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/checkout/checkout_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/home/filter_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/home/home_page.dart';
import 'package:my_cart_express/e_commerce_app/screen/home/notification_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/home/search_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/main_home/main_home.dart';
import 'package:my_cart_express/e_commerce_app/screen/favorites/favorites_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/onboarding/first_onboarding.dart';
import 'package:my_cart_express/e_commerce_app/screen/order_success/order_success_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/payment/add_new_card_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/payment/payment_method_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/product_details/product_details.dart';
import 'package:my_cart_express/e_commerce_app/screen/profile/account_info_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/profile/profile_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/splash_screen.dart';
import 'package:my_cart_express/e_commerce_app/screen/track_order/track_order_screen.dart';
part './app_routes.dart';

class AppPages {
  static final List<GetPage> pages = <GetPage>[
    GetPage(
      name: Routes.initial,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.firstOnboarding,
      page: () => const FirstOnboarding(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => const SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.mainHome,
      page: () => const MainHome(),
      binding: MainHomeBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.category,
      page: () => const CategoryScreen(),
      binding: CategoryScreenBinding(),
    ),
    GetPage(
      name: Routes.favorites,
      page: () => const FavoritesScreen(),
      binding: FavoritesScreenBinding(),
    ),
    GetPage(
      name: Routes.cart,
      page: () => const CartScreen(),
      binding: CartScreenBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: Routes.productDetails,
      page: () => const ProductDetailsScreen(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: Routes.checkout,
      page: () => const CheckoutScreen(),
      binding: CheckoutScreenBinding(),
    ),
    GetPage(
      name: Routes.deliveryAddress,
      page: () => const DeliveryAddressScreen(),
      binding: DeliveryAddressScreenBinding(),
    ),
    GetPage(
      name: Routes.addNewAddress,
      page: () => const AddNewAddressScreen(),
      binding: AddNewAddressBinding(),
    ),
    GetPage(
      name: Routes.paymentMethod,
      page: () => const PaymentMethodScreen(),
      binding: PaymentMethosScreenBinding(),
    ),
    GetPage(
      name: Routes.addNewCardScreen,
      page: () => const AddNewCardScreen(),
      binding: AddNewCardScreenBinding(),
    ),
    GetPage(
      name: Routes.orderSuccess,
      page: () => const OrderSuccessScreen(),
    ),
    GetPage(
      name: Routes.trackOrder,
      page: () => const TrackOrderScreen(),
      binding: TrackOrderScreenBinding(),
    ),
    GetPage(
      name: Routes.accountInfo,
      page: () => const AccountInfoScreen(),
      binding: AccountInfoScreenBinding(),
    ),
    GetPage(
      name: Routes.notification,
      page: () => const NotificationScreen(),
      binding: NotificationScreenBinding(),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchScreen(),
      binding: SearchScreenBinding(),
    ),
    GetPage(
      name: Routes.filter,
      page: () => const FilterScreen(),
      binding: FilterScreenBinding(),
    ),
  ];
}
