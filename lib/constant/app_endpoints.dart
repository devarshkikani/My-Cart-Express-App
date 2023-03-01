class ApiEndPoints {
  static String apiEndPoint = 'https://app.mycartexpress.com/api/v3/';
  late String imageEndPoint;
  static String authKey =
      'jayeyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTYyMDgwMDE2MSwiaWF0IjoxNjIwODAwMTYxfQ.UjYFOwih_3PrtwfJRxu6nwCwmv-e8Nbs3qAXLmdcTeYpeednas';

  static String signIn = 'login';
  static String loginImages = 'login_images';
  static String resendVerificationEmail = 'resend_verification_email';
  static String signUp = 'authentication/registration';
  static String changePassword = 'user/change_password';
  static String forgotPassword = 'authentication/forgot_password';
  static String resetPassword = 'authentication/reset_password';
  static String branches = 'branches';
  static String location = 'locations';

  static String userInfo = 'user/info';
  static String userUploadFile = 'user/upload_file';
  static String userLocation = 'user/location';
  static String userEditInfo = 'user/edit_info';
  static String userRewards = 'user/rewards';
  static String uploadProfilePicture = 'user/upload_profile_picture';

  static String balance = 'wallet/balance';
  static String howItWorks = 'dashboard/how_it_works';
  static String dashboardPackageList = 'dashboard/package_list';
  static String dashboardMessages = 'dashboard/messages';
  static String shippingPickupAddress = 'dashboard/shipping_pickup_address';

  static String shippingTracking = 'shipping/tracking/';

  static String notificationList = 'notification/list';

  static String feedbackTransactionList = 'feedback/transaction';

  static String faqList = 'faq/list';

  static String supportList = 'faq/support';
  static String supportDetails = 'support/details';
  static String sendReply = 'support/send_reply';
  static String contactAgent = 'support/contact_agent';
  static String selfCloseTicket = 'support/self_close_ticket';
  static String needAssistance = 'support/need_assistance';
  static String subjects = 'support/subjects';

  static String shippingList = 'shipping';
  static String shippingCategories = 'shipping/categories';
  static String shippingOverdue = 'shipping/overdue';
  static String availableShipping = 'shipping/available';
  static String uploadAttachments = 'shipping/upload_attachments';

  static String transactionList = 'transaction/list';

  static String authorizePickupAdd = 'authorizepickup/add';
  static String authorizePickup = 'authorize_pickup/list';
  static String authorizePickupDelete = 'authorizepickup/delete';
  static String authorizePickupType = 'authorize_pickup/authorize_pickup_type';

  static String calculateRate = 'shipping_calculator/calculate_rate?';
  static String calculatorProduct = 'shipping_calculator/product';

  static String accountDelete = 'account/delete';
}
