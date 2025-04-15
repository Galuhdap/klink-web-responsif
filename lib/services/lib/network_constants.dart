class NetworkConstants {
  //static const String BASE_URL = "https://dev.api.banksampah.techlinesolution.site/";
  // static const String BASE_URL = "http://192.168.1.2:3000/api/v1";
  //static const String BASE_URL = "http://192.168.23.144:3000/api/v1";
  static const String BASE_URL = "http://localhost:3000/api/v1";
  //static const String BASE_URL_DEV = "https://localhost:3000/";
  //static const String BASE_URL_PROD = "https://dev.api.enthusias.id";

  //login
  static const String POST_LOGIN_URL = BASE_URL + "/login";

  // static const String GET_PASIEN_URL = BASE_URL + "/admin/pasien?page=1&limit=10&search=";
  static String GET_PASIEN_URL(int page, int limit, String search) {
    return BASE_URL +
        "/admin/pasien?page=${page}&limit=${limit}&search=${search}";
  }

  static String GET_PASIEN_BYID_URL(String id) {
    return BASE_URL + "/admin/pasien/${id}";
  }

  static String POST_PASIEN_URL() {
    return BASE_URL + "/admin/pasien";
  }

  static String PUT_PASIEN_URL(String id) {
    return BASE_URL + "/admin/pasien/${id}";
  }

  static String GET_RME_ID_URL(int page, int limit, String search, String id) {
    return BASE_URL +
        "/pasien/rme/${id}?page=${page}&limit=${limit}&search=${search}";
  }

  static String GET_DOCTOR_URL(int page, int limit, String search) {
    return BASE_URL +
        "/admin/doctor?page=${page}&limit=${limit}&search=${search}";
  }
}
