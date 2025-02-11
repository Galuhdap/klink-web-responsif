
class NetworkConstants {
  //static const String BASE_URL = "https://dev.api.banksampah.techlinesolution.site/";
  static const String BASE_URL = "http://77.37.44.223:3000/";
  //static const String BASE_URL_DEV = "https://localhost:3000/";
  //static const String BASE_URL_PROD = "https://dev.api.enthusias.id";

  //login
  static const String POST_LOGIN_URL = BASE_URL + "api/login";
  static const String POST_REGISTER_CUSTOMER_URL =
      BASE_URL + "api/register-inactive";
  static const String GET_REGISTER_URL = BASE_URL + "api/super/users";
  static const String GET_ROLE_URL = BASE_URL + "api/super/role";
  static const String POST_REGISTER_URL = BASE_URL + "api/super/register";
  static const String POST_FORGOT_PASSWORD_URL =
      BASE_URL + "api/forgot-password";
  static String DELETE_REGISTER_URL(String id) {
    return BASE_URL + "api/super/users/$id";
  }

  static String UPDATE_REGISTER_URL(String id) {
    return BASE_URL + "api/super/users/$id";
  }

}
