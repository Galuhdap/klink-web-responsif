// // To parse this JSON data, do
// //
// //     final getPurchaseReportMedicineResponse = getPurchaseReportMedicineResponseFromJson(jsonString);

// import 'dart:convert';

// GetPurchaseReportMedicineResponse getPurchaseReportMedicineResponseFromJson(
//         String str) =>
//     GetPurchaseReportMedicineResponse.fromJson(json.decode(str));

// String getPurchaseReportMedicineResponseToJson(
//         GetPurchaseReportMedicineResponse data) =>
//     json.encode(data.toJson());

// class GetPurchaseReportMedicineResponse {
//   bool success;
//   int code;
//   String message;
//   Data data;

//   GetPurchaseReportMedicineResponse({
//     required this.success,
//     required this.code,
//     required this.message,
//     required this.data,
//   });

//   factory GetPurchaseReportMedicineResponse.fromJson(
//           Map<String, dynamic> json) =>
//       GetPurchaseReportMedicineResponse(
//         success: json["success"],
//         code: json["code"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "code": code,
//         "message": message,
//         "data": data.toJson(),
//       };
// }

// class Data {
//   List<DatumReportPurchase> data;
//   Pagination pagination;
//   int totalKeseluruhan;

//   Data({
//     required this.data,
//     required this.pagination,
//     required this.totalKeseluruhan,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         data: List<DatumReportPurchase>.from(
//             json["data"].map((x) => DatumReportPurchase.fromJson(x))),
//         pagination: Pagination.fromJson(json["pagination"]),
//         totalKeseluruhan: json["total_keseluruhan"],
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "pagination": pagination.toJson(),
//         "total_keseluruhan": totalKeseluruhan,
//       };
// }

// class DatumReportPurchase {
//   int no;
//   String noPembelian;
//   String supplier;
//   DateTime tanggalPembelian;
//   String userInput;
//   int total;
//   List<Detail> detail;

//   DatumReportPurchase({
//     required this.no,
//     required this.noPembelian,
//     required this.supplier,
//     required this.tanggalPembelian,
//     required this.userInput,
//     required this.total,
//     required this.detail,
//   });

//   factory DatumReportPurchase.fromJson(Map<String, dynamic> json) =>
//       DatumReportPurchase(
//         no: json["no"],
//         noPembelian: json["no_pembelian"],
//         supplier: json["supplier"],
//         tanggalPembelian: DateTime.parse(json["tanggal_pembelian"]),
//         userInput: json["user_input"],
//         total: json["total"],
//         detail:
//             List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "no": no,
//         "no_pembelian": noPembelian,
//         "supplier": supplier,
//         "tanggal_pembelian":
//             "${tanggalPembelian.year.toString().padLeft(4, '0')}-${tanggalPembelian.month.toString().padLeft(2, '0')}-${tanggalPembelian.day.toString().padLeft(2, '0')}",
//         "user_input": userInput,
//         "total": total,
//         "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
//       };
// }

// class Detail {
//   int no;
//   String namaObat;
//   int hargaBeli;
//   int jumlah;
//   DateTime tanggalExpired;
//   int subtotal;

//   Detail({
//     required this.no,
//     required this.namaObat,
//     required this.hargaBeli,
//     required this.jumlah,
//     required this.tanggalExpired,
//     required this.subtotal,
//   });

//   factory Detail.fromJson(Map<String, dynamic> json) => Detail(
//         no: json["no"],
//         namaObat: json["nama_obat"],
//         hargaBeli: json["harga_beli"],
//         jumlah: json["jumlah"],
//         tanggalExpired: json["tanggal_expired"],
//         subtotal: json["subtotal"],
//       );

//   Map<String, dynamic> toJson() => {
//         "no": no,
//         "nama_obat": namaObat,
//         "harga_beli": hargaBeli,
//         "jumlah": jumlah,
//         "tanggal_expired": tanggalExpired,
//         "subtotal": subtotal,
//       };
// }

// class Pagination {
//   int total;
//   int page;
//   int limit;
//   int totalPages;

//   Pagination({
//     required this.total,
//     required this.page,
//     required this.limit,
//     required this.totalPages,
//   });

//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         total: json["total"],
//         page: json["page"],
//         limit: json["limit"],
//         totalPages: json["totalPages"],
//       );

//   Map<String, dynamic> toJson() => {
//         "total": total,
//         "page": page,
//         "limit": limit,
//         "totalPages": totalPages,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }


// To parse this JSON data, do
//
//     final getPurchaseReportMedicineResponse = getPurchaseReportMedicineResponseFromJson(jsonString);

import 'dart:convert';

GetPurchaseReportMedicineResponse getPurchaseReportMedicineResponseFromJson(String str) => GetPurchaseReportMedicineResponse.fromJson(json.decode(str));

String getPurchaseReportMedicineResponseToJson(GetPurchaseReportMedicineResponse data) => json.encode(data.toJson());

class GetPurchaseReportMedicineResponse {
    bool success;
    int code;
    String message;
    Data data;

    GetPurchaseReportMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetPurchaseReportMedicineResponse.fromJson(Map<String, dynamic> json) => GetPurchaseReportMedicineResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    List<DatumReportPurchase> data;
    Pagination pagination;
    int totalKeseluruhan;

    Data({
        required this.data,
        required this.pagination,
        required this.totalKeseluruhan,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumReportPurchase>.from(json["data"].map((x) => DatumReportPurchase.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        totalKeseluruhan: json["total_keseluruhan"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "total_keseluruhan": totalKeseluruhan,
    };
}

class DatumReportPurchase {
    int no;
    String noPembelian;
    String supplier;
    DateTime tanggalPembelian;
    String userInput;
    int total;
    List<Detail> detail;

    DatumReportPurchase({
        required this.no,
        required this.noPembelian,
        required this.supplier,
        required this.tanggalPembelian,
        required this.userInput,
        required this.total,
        required this.detail,
    });

    factory DatumReportPurchase.fromJson(Map<String, dynamic> json) => DatumReportPurchase(
        no: json["no"],
        noPembelian: json["no_pembelian"],
        supplier: json["supplier"],
        tanggalPembelian: DateTime.parse(json["tanggal_pembelian"]),
        userInput: json["user_input"],
        total: json["total"],
        detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "no": no,
        "no_pembelian": noPembelian,
        "supplier": supplier,
        "tanggal_pembelian": "${tanggalPembelian.year.toString().padLeft(4, '0')}-${tanggalPembelian.month.toString().padLeft(2, '0')}-${tanggalPembelian.day.toString().padLeft(2, '0')}",
        "user_input": userInput,
        "total": total,
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
    };
}

class Detail {
    int no;
    String namaObat;
    int hargaBeli;
    int jumlah;
    DateTime tanggalExpired;
    int subtotal;

    Detail({
        required this.no,
        required this.namaObat,
        required this.hargaBeli,
        required this.jumlah,
        required this.tanggalExpired,
        required this.subtotal,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        no: json["no"],
        namaObat: json["nama_obat"],
        hargaBeli: json["harga_beli"],
        jumlah: json["jumlah"],
        tanggalExpired: DateTime.parse(json["tanggal_expired"]),
        subtotal: json["subtotal"],
    );

    Map<String, dynamic> toJson() => {
        "no": no,
        "nama_obat": namaObat,
        "harga_beli": hargaBeli,
        "jumlah": jumlah,
        "tanggal_expired": "${tanggalExpired.year.toString().padLeft(4, '0')}-${tanggalExpired.month.toString().padLeft(2, '0')}-${tanggalExpired.day.toString().padLeft(2, '0')}",
        "subtotal": subtotal,
    };
}

class Pagination {
    int total;
    int page;
    int limit;
    int totalPages;

    Pagination({
        required this.total,
        required this.page,
        required this.limit,
        required this.totalPages,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
