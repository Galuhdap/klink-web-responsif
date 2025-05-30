// To parse this JSON data, do
//
//     final getRoleResponse = getRoleResponseFromJson(jsonString);

import 'dart:convert';

GetRoleResponse getRoleResponseFromJson(String str) => GetRoleResponse.fromJson(json.decode(str));

String getRoleResponseToJson(GetRoleResponse data) => json.encode(data.toJson());

class GetRoleResponse {
    final bool success;
    final int code;
    final String message;
    final List<RoleData> data;

    GetRoleResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetRoleResponse copyWith({
        bool? success,
        int? code,
        String? message,
        List<RoleData>? data,
    }) => 
        GetRoleResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetRoleResponse.fromJson(Map<String, dynamic> json) => GetRoleResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<RoleData>.from(json["data"].map((x) => RoleData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class RoleData {
    final String id;
    final String name;

    RoleData({
        required this.id,
        required this.name,
    });

    RoleData copyWith({
        String? id,
        String? name,
    }) => 
        RoleData(
            id: id ?? this.id,
            name: name ?? this.name,
        );

    factory RoleData.fromJson(Map<String, dynamic> json) => RoleData(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
