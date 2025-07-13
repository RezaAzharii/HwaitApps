import 'dart:convert';

class RecommendationResponseModel {
  final int? statusCode;
  final String? message;
  final List<Recom>? data;

  RecommendationResponseModel({this.statusCode, this.message, this.data});

  factory RecommendationResponseModel.fromJson(String str) =>
      RecommendationResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecommendationResponseModel.fromMap(Map<String, dynamic> json) =>
      RecommendationResponseModel(
        statusCode: json["status_code"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<Recom>.from(json["data"]!.map((x) => Recom.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "status_code": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Recom {
  final int? id;
  final String? title;
  final int? ticket;
  final int? food;
  final int? transport;
  final int? others;
  final String? imagePath;
  final String? locationName;
  final double? latitude;
  final double? longitude;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? totalEstimated;

  Recom({
    this.id,
    this.title,
    this.ticket,
    this.food,
    this.transport,
    this.others,
    this.imagePath,
    this.locationName,
    this.latitude,
    this.longitude,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.totalEstimated,
  });

  factory Recom.fromJson(String str) => Recom.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Recom.fromMap(Map<String, dynamic> json) => Recom(
    id: json["id"],
    title: json["title"],
    ticket: json["ticket"],
    food: json["food"],
    transport: json["transport"],
    others: json["others"],
    imagePath: json["image_path"],
    locationName: json["location_name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    description: json["description"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    totalEstimated: json["total_estimated"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "ticket": ticket,
    "food": food,
    "transport": transport,
    "others": others,
    "image_path": imagePath,
    "location_name": locationName,
    "latitude": latitude,
    "longitude": longitude,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "total_estimated": totalEstimated,
  };
}
