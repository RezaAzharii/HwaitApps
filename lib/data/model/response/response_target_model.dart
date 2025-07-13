import 'dart:convert';

class TargetResponseModel {
  final int? statusCode;
  final String? message;
  final List<Target>? data;

  TargetResponseModel({this.statusCode, this.message, this.data});

  factory TargetResponseModel.fromJson(String str) =>
      TargetResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TargetResponseModel.fromMap(Map<String, dynamic> json) =>
      TargetResponseModel(
        statusCode: json["status_code"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<Target>.from(
                  json["data"]!.map((x) => Target.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "status_code": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Target {
  final int? id;
  final int? userId;
  final String? title;
  final double? ticket;
  final double? food;
  final double? transport;
  final double? others;
  final double? totalTarget;
  final double? totalSetoran;
  final double? persentaseProgres;
  final String? imagePath;
  final String? locationName;
  final double? latitude;
  final double? longitude;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Progres>? progres;

  Target({
    this.id,
    this.userId,
    this.title,
    this.ticket,
    this.food,
    this.transport,
    this.others,
    this.totalTarget,
    this.totalSetoran,
    this.persentaseProgres,
    this.imagePath,
    this.locationName,
    this.latitude,
    this.longitude,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.progres,
  });

  factory Target.fromJson(String str) => Target.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Target.fromMap(Map<String, dynamic> json) => Target(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    ticket: json["ticket"] == null ? null : double.tryParse(json["ticket"]),
    food: json["food"] == null ? null : double.tryParse(json["food"]),
    transport:
        json["transport"] == null ? null : double.tryParse(json["transport"]),
    others: json["others"] == null ? null : double.tryParse(json["others"]),
    totalTarget:
        json["total_target"] == null
            ? 0.0
            : (json["total_target"] is int
                ? (json["total_target"] as int).toDouble()
                : (json["total_target"] as num).toDouble()),

    totalSetoran:
        json["total_setoran"] == null
            ? 0.0
            : (json["total_setoran"] is int
                ? (json["total_setoran"] as int).toDouble()
                : (json["total_setoran"] as num).toDouble()),

    persentaseProgres: json["persentase_progres"]?.toDouble(),
    imagePath: json["image_path"],
    locationName: json["location_name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    status: json["status"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    progres:
        json["progres"] == null
            ? []
            : List<Progres>.from(
              json["progres"]!.map((x) => Progres.fromMap(x)),
            ),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "ticket": ticket,
    "food": food,
    "transport": transport,
    "others": others,
    "total_target": totalTarget,
    "total_setoran": totalSetoran,
    "persentase_progres": persentaseProgres,
    "image_path": imagePath,
    "location_name": locationName,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "progres":
        progres == null
            ? []
            : List<dynamic>.from(progres!.map((x) => x.toMap())),
  };
}

class Progres {
  final int? id;
  final int? targetId;
  final String? setoran;
  final DateTime? tanggalSetoran;
  final DateTime? waktuSetoran;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Progres({
    this.id,
    this.targetId,
    this.setoran,
    this.tanggalSetoran,
    this.waktuSetoran,
    this.createdAt,
    this.updatedAt,
  });

  factory Progres.fromJson(String str) => Progres.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Progres.fromMap(Map<String, dynamic> json) => Progres(
    id: json["id"],
    targetId: json["target_id"],
    setoran: json["setoran"],
    tanggalSetoran:
        json["tanggal_setoran"] == null
            ? null
            : DateTime.parse(json["tanggal_setoran"]),
    waktuSetoran:
        json["waktu_setoran"] == null
            ? null
            : DateTime.parse(json["waktu_setoran"]),
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "target_id": targetId,
    "setoran": setoran,
    "tanggal_setoran": tanggalSetoran?.toIso8601String(),
    "waktu_setoran": waktuSetoran?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
