class ApiEndPoints {
  static String apiEndPoint = 'https://app.mycartexpress.com/api/';
  late String imageEndPoint;
  static String authKey =
      'jayeyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTYyMDgwMDE2MSwiaWF0IjoxNjIwODAwMTYxfQ.UjYFOwih_3PrtwfJRxu6nwCwmv-e8Nbs3qAXLmdcTeYpeednas';

  static String signIn = 'login';
  static String signUp = 'authentication/registration';
  static String changePassword = 'user/change_password';
  static String forgotPassword =
      'courier_server/api/authentication/forgot_password';
  static String branches = 'branches';

  static String balance = 'wallet/balance';
  static String customerShippingAddress = 'customer/shipping_address';
  static String dashboardPackageList = 'dashboard/package_list';
  static String dashboardMessages = 'dashboard/messages';

  static String notificationList = 'notification/list';

  static String faqList = 'faq/list';

  static String shippingList = 'shipping';
  static String availableShipping = 'shipping/available';

  static String transactionList = 'transaction/list';

  static String authorizePickupAdd = 'authorizepickup/add';
  static String authorizePickup = 'authorize_pickup/list';
  static String authorizePickupDelete = 'authorizepickup/delete';
  static String authorizePickupType = 'authorize_pickup/authorize_pickup_type';

  static String calculateRate = 'shipping_calculator/calculate_rate?';
  static String calculatorProduct = 'shipping_calculator/product';
}
