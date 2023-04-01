part of 'e_app_pages.dart';

abstract class ERoutes {
  static const String initial = '/';
  static const String firstOnboarding = '/firstOnboarding';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';

  static const String mainHome = '/main_home';

  static const String home = '/main_home/';
  static const String category = '/main_home/category';
  static const String favorites = '/main_home/favorites';
  static const String cart = '/main_home/cart';
  static const String profile = '/main_home/profile';

  static const String productDetails = '/main_home/home/productDetails';
  static const String checkout = '/main_home/home/check_out';
  static const String deliveryAddress =
      '/main_home/home/check_out/delivery_address';
  static const String addNewAddress =
      '/main_home/home/check_out/add_new_address';
  static const String paymentMethod =
      '/main_home/home/check_out/payment_method';
  static const String addNewCardScreen =
      '/main_home/home/check_out/payment_method/add_new_card_screen';
  static const String orderSuccess =
      '/main_home/home/check_out/payment_method/add_new_card_screen/orderSuccess';

  static const String trackOrder = '/main_home/track_order';
  static const String accountInfo = '/main_home/profile/account_info';

  static const String notification = '/main_home/home/notification';
  static const String search = '/main_home/home/search_screen';
  static const String filter = '/main_home/home/search_screen/filter';

  static const String details = '/home/details';
}
