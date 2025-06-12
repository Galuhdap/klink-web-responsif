// To parse this JSON data, do
//
//     final postNewMedicineResponse = postNewMedicineResponseFromJson(jsonString);

import 'dart:convert';

PostNewMedicineResponse postNewMedicineResponseFromJson(String str) => PostNewMedicineResponse.fromJson(json.decode(str));

String postNewMedicineResponseToJson(PostNewMedicineResponse data) => json.encode(data.toJson());

class PostNewMedicineResponse {
    bool success;
    int code;
    String message;
    Data data;

    PostNewMedicineResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory PostNewMedicineResponse.fromJson(Map<String, dynamic> json) => PostNewMedicineResponse(
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
    String id;
    String nameMedicine;
    String baseUnitId;
    int priceSell;
    DateTime createdAt;
    List<UnitConversion> unitConversions;
    Unit baseUnit;

    Data({
        required this.id,
        required this.nameMedicine,
        required this.baseUnitId,
        required this.priceSell,
        required this.createdAt,
        required this.unitConversions,
        required this.baseUnit,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nameMedicine: json["name_medicine"],
        baseUnitId: json["baseUnitId"],
        priceSell: json["price_sell"],
        createdAt: DateTime.parse(json["createdAt"]),
        unitConversions: List<UnitConversion>.from(json["unitConversions"].map((x) => UnitConversion.fromJson(x))),
        baseUnit: Unit.fromJson(json["baseUnit"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_medicine": nameMedicine,
        "baseUnitId": baseUnitId,
        "price_sell": priceSell,
        "createdAt": createdAt.toIso8601String(),
        "unitConversions": List<dynamic>.from(unitConversions.map((x) => x.toJson())),
        "baseUnit": baseUnit.toJson(),
    };
}

class Unit {
    String id;
    String name;
    int level;

    Unit({
        required this.id,
        required this.name,
        required this.level,
    });

    factory Unit.fromJson(Map<String, dynamic> json) => Unit(
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

class UnitConversion {
    String id;
    String medicineId;
    String unitId;
    int multiplier;
    Unit unit;

    UnitConversion({
        required this.id,
        required this.medicineId,
        required this.unitId,
        required this.multiplier,
        required this.unit,
    });

    factory UnitConversion.fromJson(Map<String, dynamic> json) => UnitConversion(
        id: json["id"],
        medicineId: json["medicineId"],
        unitId: json["unitId"],
        multiplier: json["multiplier"],
        unit: Unit.fromJson(json["unit"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "medicineId": medicineId,
        "unitId": unitId,
        "multiplier": multiplier,
        "unit": unit.toJson(),
    };
}
