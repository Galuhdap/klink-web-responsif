// To parse this JSON data, do
//
//     final getUnitResponse = getUnitResponseFromJson(jsonString);

import 'dart:convert';

import 'package:klinik_web_responsif/services/apotik/model/response/get_group_stock_medicine_response.dart';
import 'package:klinik_web_responsif/services/apotik/model/response/post_new_medicine_response.dart';

GetUnitResponse getUnitResponseFromJson(String str) =>
    GetUnitResponse.fromJson(json.decode(str));

String getUnitResponseToJson(GetUnitResponse data) =>
    json.encode(data.toJson());

class GetUnitResponse {
  bool success;
  int code;
  String message;
  Data data;

  GetUnitResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetUnitResponse.fromJson(Map<String, dynamic> json) =>
      GetUnitResponse(
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
  List<DatumUnit> data;
  Pagination pagination;

  Data({
    required this.data,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<DatumUnit>.from(
            json["data"].map((x) => DatumUnit.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class DatumUnit {
  int? no;
  String id;
  String name;
  int? level;

  DatumUnit({
    this.no,
    required this.id,
    required this.name,
    this.level,
  });

  factory DatumUnit.fromJson(Map<String, dynamic> json) => DatumUnit(
        no: json["no"],
        id: json["id"],
        name: json["name"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "name": name,
        "level": level,
      };

  factory DatumUnit.fromUnit(UnitS unit) {
    return DatumUnit(
      id: unit.id,
      name: unit.name,
      level: unit.level,
    );
  }
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
