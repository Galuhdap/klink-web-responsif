import 'package:get/get.dart';

class HomeController extends GetxController {

  RxString role = 'docter'.obs;

  RxList patient = [
    {
      "nomor_antrian": "20",
      "nama_pasien": "Sabah",
      "jenis_kelamin": "Laki-Laki",
      "tanggal_lahir": "sdasdas",
      "alamat": "sdasdas",
      "rm": "RM-110",
      "nik": "sdasdas",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "menunggu"
    },
    {
      "nomor_antrian": "12",
      "nama_pasien": "Yukya",
      "jenis_kelamin": "Laki-Laki",
      "tanggal_lahir": "sdasdas",
      "alamat": "sdasdas",
      "rm": "RM-112",
      "nik": "sdasdas",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "pending"
    },
    {
      "nomor_antrian": "13",
      "nama_pasien": "Moni",
      "jenis_kelamin": "Perempuan",
      "tanggal_lahir": "sdasdas",
      "alamat": "sdasdas",
      "rm": "RM-330",
      "nik": "sdasdas",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "proses"
    },
    {
      "nomor_antrian": "09",
      "nama_pasien": "Sizuka",
      "jenis_kelamin": "Perempuan",
      "tanggal_lahir": "sdasdas",
      "alamat": "sdasdas",
      "rm": "RM-9900",
      "nik": "sdasdas",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "dibatalkan"
    },
    {
      "nomor_antrian": "02",
      "nama_pasien": "monaji",
      "jenis_kelamin": "Laki-Laki",
      "tanggal_lahir": "sdasdas",
      "alamat": "sdasdas",
      "rm": "RM-1203",
      "nik": "sdasdas",
      "no_telp": "sdasdas",
      "action": "sdasdas",
      "status": "selesai"
    },
   
  ].obs;
}
