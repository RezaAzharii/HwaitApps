import 'dart:convert';

class SetoranResponseModel {
    final int? statusCode;
    final String? message;
    final Data? data;

    SetoranResponseModel({
        this.statusCode,
        this.message,
        this.data,
    });

    factory SetoranResponseModel.fromJson(String str) => SetoranResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SetoranResponseModel.fromMap(Map<String, dynamic> json) => SetoranResponseModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toMap(),
    };
}

class Data {
    final int? targetId;
    final int? setoran;
    final DateTime? tanggalSetoran;
    final String? waktuSetoran;
    final int? userId;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Data({
        this.targetId,
        this.setoran,
        this.tanggalSetoran,
        this.waktuSetoran,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        targetId: json["target_id"],
        setoran: json["setoran"],
        tanggalSetoran: json["tanggal_setoran"] == null ? null : DateTime.parse(json["tanggal_setoran"]),
        waktuSetoran: json["waktu_setoran"],
        userId: json["user_id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "target_id": targetId,
        "setoran": setoran,
        "tanggal_setoran": tanggalSetoran?.toIso8601String(),
        "waktu_setoran": waktuSetoran,
        "user_id": userId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
