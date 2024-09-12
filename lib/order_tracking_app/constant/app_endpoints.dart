class ApiEndPoints {
  static String apiEndPoint = 'https://app.mycartexpress.com/api/v7/';
  late String imageEndPoint;
  static String authKey =
      'jayeyJhbGciOiJIUzI1NiJ9.eyJSb2xlIjoiQWRtaW4iLCJJc3N1ZXIiOiJJc3N1ZXIiLCJVc2VybmFtZSI6IkphdmFJblVzZSIsImV4cCI6MTYyMDgwMDE2MSwiaWF0IjoxNjIwODAwMTYxfQ.UjYFOwih_3PrtwfJRxu6nwCwmv-e8Nbs3qAXLmdcTeYpeednas';

  static String signIn = 'login';
  static String loginImages = 'login_images';
  static String resendVerificationEmail = 'resend_verification_email';
  static String signUp = 'authentication/registration';
  static String changePassword = 'user/change_password';
  static String editName = 'user/edit_name';
  static String editPhone = 'user/edit_phone';
  static String forgotPassword = 'authentication/forgot_password';
  static String resetPassword = 'authentication/reset_password';
  static String branches = 'sign_up_branch_listing';
  static String switchBranch = 'switch_branch';
  static String location = 'locations';

  static String userInfo = 'user/info';
  static String userUploadFiles = 'user/uploaded_files';
  static String uploadFileAttachment = 'user/upload_file_attachment';
  static String userLocation = 'user/location';
  static String userEditInfo = 'user/edit_info';
  static String userRewards = 'user/rewards';
  static String updateAppVersion = 'user/edit_user_app_version_info';
  static String saveSplashScreenUser = 'user/save_splash_screen_user';
  static String uploadProfilePicture = 'user/upload_profile_picture';
  static String uploadMissingPackage = 'user/upload_missing_package';
  static String missingPackageMessage = 'user/missing_package_message';
  static String openMissingPackages = 'user/open_missing_packages';

  static String balance = 'wallet_balance';
  static String howItWorks = 'dashboard/how_it_works';
  static String branchBannerImages = 'branch_banner_images';
  static String dashboardPackageList = 'dashboard/package_list';
  static String dashboardMessages = 'dashboard/messages';
  static String shippingPickupAddress = 'dashboard/shipping_pickup_address';

  static String shippingTracking = 'shipping/tracking/';
  static String shippingCount = 'shipping/counts';

  static String notificationList = 'notification/list';

  static String feedbackTransactionList = 'feedback/transaction';
  static String feedbackSend = 'feedback/send';
  static String download = 'transaction/';
  static String preview = 'transaction/';

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

  static String refreshToken = 'refresh_token';

  static String splashScreenVideo = 'splash_screen_video';

  static String saveAppRating = 'customer/save_app_rating';
  static String getBranchReviewDetails = 'get_branch_review_settings_details';

  static String commonSettings = 'common_settings';
  static String apiVersion = 'common_settings/api_version';

  static String getFeedbackNotAdded = 'transaction/get_feedback_not_added';
  static String saveUserFeedbackPopup = 'transaction/save_user_feedback_popup';
}
