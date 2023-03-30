class ApiEndPoints {
  static String apiEndPoint =
      'http://finder-env.eba-iy4kjhkc.ap-south-1.elasticbeanstalk.com/';
  late String imageEndPoint;

  static String signIn = 'user/signIn';
  static String signUp = 'user/signUp';

  static String appleLogin = 'user/apple';
  static String googleLogin = 'user/google';

  static String otpVerify = 'user/otpVerification';
  static String resendOTP = 'user/resendOTP';
  static String registerUserDetails = 'user/register_user_details';

  static String uploadImages = 'upload/profile';

  static String homeAPI = 'user/home';

  static String addRoom = 'user/room/add';
  static String getRooms = 'user/room';
  static String getMessage = 'user/message?roomId=';

  static String updateUserStatus = 'user/online_offline';
}
