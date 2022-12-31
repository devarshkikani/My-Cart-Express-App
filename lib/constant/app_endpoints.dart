class ApiEndPoints {
  static String apiEndPoint = 'https://app.mycartexpress.com/api/';
  late String imageEndPoint;
  static String authKey =
      'jayeyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTYyMDgwMDE2MSwiaWF0IjoxNjIwODAwMTYxfQ.UjYFOwih_3PrtwfJRxu6nwCwmv-e8Nbs3qAXLmdcTeYpeednas';

  static String signIn = 'login';
  static String signUp = 'authentication/registration';
  static String forgotPassword = 'authentication/forgot_password';

  static String branches = 'branches';
  static String balance = 'wallet/balance';
  static String customerShippingAddress = 'customer/shipping_address';
}
