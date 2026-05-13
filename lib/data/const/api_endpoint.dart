class ApiUrls {
  static const String baseUrlForPhoto = "";
  static const String websiteUrl = "";
  static const String websiteResultUrl = "";

  /// Auth Urls
  static const String loginUrl = "/api/v1/login";
  static const String forgotPasswordUrl = "/api/v1/forgot-password";
  static const String resendOtpUrl = "/api/v1/resend-otp";
  static const String verifyOtpUrl = "/api/v1/verify-otp";
  static const String resetPasswordUrl = "/api/v1/reset-password";

  /// Language Url
  static const String languageUrl = "/api/v1/languages";

  /// Profile Url
  static const String profileInfoUrl = "/api/v1/driver/profile";

  /// Reviews Url
  static const String reviewsUrl = "/api/v1/reviews";

  /// Reservation Url
  static const String collectionsUrl = "/api/v1/collections";
  static const String takenListUrl = "/api/v1/takens";
  static const String collectionDetailsUrl = "/api/v1/collections/";
  static const String equipmentDetailsUrl = "/api/v1/equipment/";
  static const String completeReservationUrl = "/api/v1/collections/";
  static const String viewReservationUrl = "/api/v1/view/";

  /// Location Url
  static const String sendLocationUrl = "/api/v1/driver/location";

  /// Fcm Url
  static const String updateFcmTokenUrl = "/api/v1/driver/update-fcm-token";
  static const String resetFcmTokenUrl = "/api/v1/exit";

  /// User Info
  static const String userToken = "user_token";
  static const String refreshToken = "refresh_token";
  static const String userIP = "user_ip";
  static const String attendanceDate = "attendance_date";
  static const String userLuckyCardList = "user_lucky_card_list";
  static const String userDonationList = "user_donation_list";
  static const String selectedLanguage = "selected_language";
}
