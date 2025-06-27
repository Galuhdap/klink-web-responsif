// To parse this JSON data, do
//
//     final postTransactionResponse = postTransactionResponseFromJson(jsonString);

import 'dart:convert';

PostTransactionResponse postTransactionResponseFromJson(String str) =>
    PostTransactionResponse.fromJson(json.decode(str));

String postTransactionResponseToJson(PostTransactionResponse data) =>
    json.encode(data.toJson());

class PostTransactionResponse {
  bool success;
  int code;
  String message;
  TransactionPost data;

  PostTransactionResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory PostTransactionResponse.fromJson(Map<String, dynamic> json) =>
      PostTransactionResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: TransactionPost.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class TransactionPost {
  String id;
  String invoice;
  String paymentMethod;
  int nominalPayment;
  int doctorFee;
  int totalPayment;
  DateTime createdAt;
  String rekamMedisid;
  String userId;
  int amountPaid;
  int changeGiven;
  List<Obat> obat;

  TransactionPost({
    required this.id,
    required this.invoice,
    required this.paymentMethod,
    required this.nominalPayment,
    required this.doctorFee,
    required this.totalPayment,
    required this.createdAt,
    required this.rekamMedisid,
    required this.userId,
    required this.amountPaid,
    required this.changeGiven,
    required this.obat,
  });

  factory TransactionPost.fromJson(Map<String, dynamic> json) =>
      TransactionPost(
        id: json["id"],
        invoice: json["invoice"],
        paymentMethod: json["payment_method"],
        nominalPayment: json["nominal_payment"],
        doctorFee: json["doctorFee"],
        totalPayment: json["totalPayment"],
        createdAt: DateTime.parse(json["createdAt"]),
        rekamMedisid: json["rekam_medisid"],
        userId: json["userId"],
        amountPaid: json["amount_paid"],
        changeGiven: json["change_given"],
        obat: List<Obat>.from(json["obat"].map((x) => Obat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice": invoice,
        "payment_method": paymentMethod,
        "nominal_payment": nominalPayment,
        "doctorFee": doctorFee,
        "totalPayment": totalPayment,
        "createdAt": createdAt.toIso8601String(),
        "rekam_medisid": rekamMedisid,
        "userId": userId,
        "amount_paid": amountPaid,
        "change_given": changeGiven,
        "obat": List<dynamic>.from(obat.map((x) => x.toJson())),
      };
}

class Obat {
  String medicineId;
  String namaObat;
  int jumlah;
  String satuan;
  int hargaSatuan;
  int total;

  Obat({
    required this.medicineId,
    required this.namaObat,
    required this.jumlah,
    required this.satuan,
    required this.hargaSatuan,
    required this.total,
  });

  factory Obat.fromJson(Map<String, dynamic> json) => Obat(
        medicineId: json["medicineId"],
        namaObat: json["nama_obat"],
        jumlah: json["jumlah"],
        satuan: json["satuan"],
        hargaSatuan: json["harga_satuan"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "medicineId": medicineId,
        "nama_obat": namaObat,
        "jumlah": jumlah,
        "satuan": satuan,
        "harga_satuan": hargaSatuan,
        "total": total,
      };
}
