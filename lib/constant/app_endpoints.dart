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
  static String notificationList = 'notification/list';
  static String walletTransaction = 'wallet/transaction';
  static String faqList = 'faq/list';
  static String pickupAdd = 'authorizepickup/add';
  static String pickupType = 'authorize_pickup/authorize_pickup_type';
}
