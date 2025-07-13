import 'dart:convert';

class RiwayatTabunganResponseModel {
  final int? statusCode;
  final String? message;
  final List<RiwayatTabungan>? data;

  RiwayatTabunganResponseModel({this.statusCode, this.message, this.data});

  factory RiwayatTabunganResponseModel.fromJson(String str) =>
      RiwayatTabunganResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RiwayatTabunganResponseModel.fromMap(Map<String, dynamic> json) =>
      RiwayatTabunganResponseModel(
        statusCode: json["status_code"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<RiwayatTabungan>.from(json["data"]!.map((x) => RiwayatTabungan.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "status_code": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class RiwayatTabungan {
  final int? id;
  final int? userId;
  final String? title;
  final String? ticket;
  final String? food;
  final String? transport;
  final String? others;
  final String? imagePath;
  final String? locationName;
  final double? latitude;
  final double? longitude;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RiwayatTabungan({
    this.id,
    this.userId,
    this.title,
    this.ticket,
    this.food,
    this.transport,
    this.others,
    this.imagePath,
    this.locationName,
    this.latitude,
    this.longitude,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory RiwayatTabungan.fromJson(String str) =>
      RiwayatTabungan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RiwayatTabungan.fromMap(Map<String, dynamic> json) => RiwayatTabungan(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    ticket: json["ticket"],
    food: json["food"],
    transport: json["transport"],
    others: json["others"],
    imagePath: json["image_path"],
    locationName: json["location_name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    status: json["status"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "ticket": ticket,
    "food": food,
    "transport": transport,
    "others": others,
    "image_path": imagePath,
    "location_name": locationName,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
