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
  static String GET_PASIEN_URL(
      int page, int limit, String name, String nik, String umur, String norme) {
    return BASE_URL +
        "/admin/pasien?page=${page}&limit=${limit}&name=${name}&nik=${nik}&umur=${umur}&no_rekam_medis=${norme}";
  }

  static String GET_STATISTIC_TOTAL_PASIEN_URL() {
    return BASE_URL + "/queue/pasien/stat";
  }

  static String DEL_ANTRIAN_ID_URL(String id) {
    return BASE_URL + "/queue/clear/${id}";
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

  static String GET_ANTRIAN_PASIEN_URL(
      int page, int limit, String name, String nomer_antrian, String no_rme) {
    return BASE_URL +
        "/queue/pasien?page=${page}&limit=${limit}&name=${name}&nomer_antrian=${nomer_antrian}&no_rme=${no_rme}";
  }

  static String GET_ANTRIAN_PASIEN_FINISHED_URL(
      int page, int limit, String name, String nomer_antrian, String no_rme) {
    return BASE_URL +
        "/queue/pasien/finished?page=${page}&limit=${limit}&name=${name}&nomer_antrian=${nomer_antrian}&no_rme=${no_rme}";
  }

  static String GET_ANTRIAN_PROSES_PASIEN_URL(
      int page, int limit, String search) {
    return BASE_URL +
        "/doctor/pasien/queque?page=${page}&limit=${limit}&search=${search}";
  }

  static String POST_ANTRIAN_PASIEN_URL(String id) {
    return BASE_URL + "/queue/pasien/${id}";
  }

  static String PUT_ANTRIAN_PASIEN_URL(String id) {
    return BASE_URL + "/queue/pasien/${id}";
  }

  static String GET_RME_ID_URL(int page, int limit, String start_date,
      String end_date, String keluhan, String id) {
    return BASE_URL +
        "/pasien/rme/${id}?page=${page}&limit=${limit}&start_date=${start_date}&end_date=${end_date}&keluhan=${keluhan}";
  }

  static String POST_RME_URL() {
    return BASE_URL + "/pasien/rme";
  }

  static String GET_DOCTOR_URL(int page, int limit, String name, String nik) {
    return BASE_URL +
        "/admin/doctor?page=${page}&limit=${limit}&name=${name}&nik=${nik}";
  }

  static String GET_MEDICINE_URL(int page, int limit, String nama_obat) {
    return BASE_URL +
        "/apotik/obat?page=${page}&limit=${limit}&nama_obat=${nama_obat}";
  }

  static String POST_MEDICINE_URL() {
    return BASE_URL + "/apotik/obat";
  }

  static String PUT_MEDICINE_URL(String id) {
    return BASE_URL + "/apotik/obat/${id}";
  }

  static String PUT_STATUS_MEDICINE_URL(String id) {
    return BASE_URL + "/apotik/obat/status/${id}";
  }

  static String GET_TRANSCATION_URL(
      int page, int limit, String inv, String name) {
    return BASE_URL +
        "/apotik/transaction?page=${page}&limit=${limit}&invoice=${inv}&name=${name}";
  }

  static String GET_TRANSACTION_PASIEN_ID_URL(String id) {
    return BASE_URL + "/apotik/transaction/${id}";
  }

  static String POST_TRANSACTION_PASIEN() {
    return BASE_URL + "/apotik/transaction";
  }

  static String GET_USER_URL(int page, int limit, String name, String nik) {
    return BASE_URL +
        "/owner/user?page=${page}&limit=${limit}&name=${name}&nik=${nik}";
  }

  static String POST_USER_URL() {
    return BASE_URL + "/owner/user";
  }

  static String PUT_USER_URL(String id) {
    return BASE_URL + "/owner/user/${id}";
  }

  static String GET_ROLE_URL() {
    return BASE_URL + "/owner/user/role";
  }

  //NEW SYSTEM APOTIK
  static String GET_MEDICINE_EXPIRED_URL(int page, int limit) {
    return BASE_URL + "/apotik/expired/medicine?page=${page}&limit=${limit}";
  }

  static String GET_MEDICINE_HAS_EXPIRED_URL(int page, int limit) {
    return BASE_URL + "/apotik/hasexpired/medicine?page=${page}&limit=${limit}";
  }

  static String DELETE_MEDICINE_HAS_EXPIRED_URL(String id) {
    return BASE_URL + "/apotik/hasexpired/medicine/${id}";
  }

  static String GET_MEDICINE_TOP_FIVE_URL() {
    return BASE_URL + "/apotik/topfive/medicine";
  }

  static String GET_MEDICINE_SUMMARY_MONTHLY_URL() {
    return BASE_URL + "/apotik/summary/medicine";
  }

  static String GET_MEDICINE_SUMMARY_DAILY_URL() {
    return BASE_URL + "/apotik/report/daily/medicine";
  }

  static String GET_MEDICINE_GROUP_STOCK_URL(
      int page, int limit, String name_medicine) {
    return BASE_URL +
        "/apotik/stock/medicine?page=${page}&limit=${limit}&name_medicine=${name_medicine}";
  }

  static String GET_MEDICINE_GROUP_STOCK_ZERO_URL(
      int page, int limit, String name_medicine) {
    return BASE_URL +
        "/apotik/stock/medicine/zero?page=${page}&limit=${limit}&name_medicine=${name_medicine}";
  }

  static String POST_MEDICINE_BUY_URL() {
    return BASE_URL + "/apotik/buy/medicine";
  }

  static String POST_NEW_MEDICINE_URL() {
    return BASE_URL + "/apotik/medicine";
  }

  static String PUT_NEW_MEDICINE_URL(String id) {
    return BASE_URL + "/apotik/medicine/${id}";
  }

  static String DELETE_NEW_MEDICINE_URL(String id) {
    return BASE_URL + "/apotik/medicine/${id}";
  }

  static String POST_UNIT_NEW_MEDICINE_URL() {
    return BASE_URL + "/apotik/medicine/unit";
  }

  static String PUT_UNIT_NEW_MEDICINE_URL(String id) {
    return BASE_URL + "/apotik/medicine/unit/${id}";
  }

  static String DELETE_UNIT_NEW_MEDICINE_URL(String id) {
    return BASE_URL + "/apotik/medicine/unit/${id}";
  }

  static String GET_REPORT_MEDICINE_BUY_URL(int page, int limit,
      String start_date, String end_date, String no_buy, String name_supplier) {
    return BASE_URL +
        "/apotik/purchase/medicine?page=${page}&limit=${limit}&start_date=${start_date}&end_date=${end_date}&no_buy=${no_buy}&name_supplier=${name_supplier}";
  }

  static String GET_SALE_MEDICINE_BUY_URL(
      int page,
      int limit,
      String start_date,
      String end_date,
      String invoice,
      String no_rekam_medis,
      String name) {
    return BASE_URL +
        "/apotik/sale/medicine?page=${page}&limit=${limit}&start_date=${start_date}&end_date=${end_date}&invoice=${invoice}&no_rekam_medis=${no_rekam_medis}&name=${name}";
  }

  static String GET_IN_OUT_MEDICINE_BUY_URL(
      int page, int limit, String start_date, String end_date, String no_buy) {
    return BASE_URL +
        "/apotik/report/inout/medicine?page=${page}&limit=${limit}&start_date=${start_date}&end_date=${end_date}";
  }

  static String GET_NEW_MEDICINE_URL(
      int page, int limit, String name_medicine) {
    return BASE_URL +
        "/apotik/medicine?page=${page}&limit=${limit}&name_medicine=${name_medicine}";
  }

  static String GET_UNIT_URL(int page, int limit, String name) {
    return BASE_URL +
        "/apotik/medicine/unit?page=${page}&limit=${limit}&name=${name}";
  }

  static String GET_CHART_REPORT_DAILY_URL() {
    return BASE_URL + "/report/chart/report/daily/trend";
  }

  static String GET_CHART_REPORT_DAILY_SUMMARY_URL() {
    return BASE_URL + "/report/chart/report/daily/summary";
  }

  static String GET_CHART_REPORT_DAILY_SALE_MEDICINE_URL() {
    return BASE_URL + "/report/chart/report/daily/sale/medicine";
  }

  static String GET_SUMMARY_DOCTOR_URL(String id) {
    return BASE_URL + "/doctor/summary/${id}";
  }

  static String GET_REPORT_SELL_LOW_MEDICINE_URL() {
    return BASE_URL + "/report/chart/report/low/stock/medicine";
  }
}
