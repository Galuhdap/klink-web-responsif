// To parse this JSON data, do
//
//     final postTransactionResponse = postTransactionResponseFromJson(jsonString);

import 'dart:convert';

PostTransactionResponse postTransactionResponseFromJson(String str) => PostTransactionResponse.fromJson(json.decode(str));

String postTransactionResponseToJson(PostTransactionResponse data) => json.encode(data.toJson());

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

    factory PostTransactionResponse.fromJson(Map<String, dynamic> json) => PostTransactionResponse(
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
    List<DetailSellMedicine> detailSellMedicine;
    int amountPaid;
    int changeGiven;

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
        required this.detailSellMedicine,
        required this.amountPaid,
        required this.changeGiven,
    });

    factory TransactionPost.fromJson(Map<String, dynamic> json) => TransactionPost(
        id: json["id"],
        invoice: json["invoice"],
        paymentMethod: json["payment_method"],
        nominalPayment: json["nominal_payment"],
        doctorFee: json["doctorFee"],
        totalPayment: json["totalPayment"],
        createdAt: DateTime.parse(json["createdAt"]),
        rekamMedisid: json["rekam_medisid"],
        userId: json["userId"],
        detailSellMedicine: List<DetailSellMedicine>.from(json["detailSellMedicine"].map((x) => DetailSellMedicine.fromJson(x))),
        amountPaid: json["amount_paid"],
        changeGiven: json["change_given"],
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
        "detailSellMedicine": List<dynamic>.from(detailSellMedicine.map((x) => x.toJson())),
        "amount_paid": amountPaid,
        "change_given": changeGiven,
    };
}

class DetailSellMedicine {
    String id;
    int amountMedicine;
    int priceSell;
    int totalSell;
    DateTime createdAt;
    String medicineId;
    String sellMedicineId;
    String unitId;
    Medicine medicine;

    DetailSellMedicine({
        required this.id,
        required this.amountMedicine,
        required this.priceSell,
        required this.totalSell,
        required this.createdAt,
        required this.medicineId,
        required this.sellMedicineId,
        required this.unitId,
        required this.medicine,
    });

    factory DetailSellMedicine.fromJson(Map<String, dynamic> json) => DetailSellMedicine(
        id: json["id"],
        amountMedicine: json["amount_medicine"],
        priceSell: json["price_sell"],
        totalSell: json["total_sell"],
        createdAt: DateTime.parse(json["createdAt"]),
        medicineId: json["medicineId"],
        sellMedicineId: json["sellMedicineId"],
        unitId: json["unitId"],
        medicine: Medicine.fromJson(json["Medicine"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount_medicine": amountMedicine,
        "price_sell": priceSell,
        "total_sell": totalSell,
        "createdAt": createdAt.toIso8601String(),
        "medicineId": medicineId,
        "sellMedicineId": sellMedicineId,
        "unitId": unitId,
        "Medicine": medicine.toJson(),
    };
}

class Medicine {
    String id;
    String nameMedicine;
    String baseUnitId;
    int priceSell;
    DateTime createdAt;
    BaseUnit baseUnit;

    Medicine({
        required this.id,
        required this.nameMedicine,
        required this.baseUnitId,
        required this.priceSell,
        required this.createdAt,
        required this.baseUnit,
    });

    factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json["id"],
        nameMedicine: json["name_medicine"],
        baseUnitId: json["baseUnitId"],
        priceSell: json["price_sell"],
        createdAt: DateTime.parse(json["createdAt"]),
        baseUnit: BaseUnit.fromJson(json["baseUnit"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_medicine": nameMedicine,
        "baseUnitId": baseUnitId,
        "price_sell": priceSell,
        "createdAt": createdAt.toIso8601String(),
        "baseUnit": baseUnit.toJson(),
    };
}

class BaseUnit {
    String id;
    String name;
    int level;

    BaseUnit({
        required this.id,
        required this.name,
        required this.level,
    });

    factory BaseUnit.fromJson(Map<String, dynamic> json) => BaseUnit(
        id: json["id"],
        name: json["name"],
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "level": level,
    };
}
