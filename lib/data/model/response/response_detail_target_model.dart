import 'dart:convert';

class ResponseDetailTargetModel {
  final int? statusCode;
  final String? message;
  final Data? data;

  ResponseDetailTargetModel({this.statusCode, this.message, this.data});

  factory ResponseDetailTargetModel.fromJson(String str) =>
      ResponseDetailTargetModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseDetailTargetModel.fromMap(Map<String, dynamic> json) =>
      ResponseDetailTargetModel(
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
  final TargetD? target;
  final int? totalSetoran;
  final int? totalTarget;
  final String? persentaseProgres;

  Data({
    this.target,
    this.totalSetoran,
    this.totalTarget,
    this.persentaseProgres,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    target: json["target"] == null ? null : TargetD.fromMap(json["target"]),
    totalSetoran: json["total_setoran"],
    totalTarget: json["total_target"],
    persentaseProgres: json["persentase_progres"],
  );

  Map<String, dynamic> toMap() => {
    "target": target?.toMap(),
    "total_setoran": totalSetoran,
    "total_target": totalTarget,
    "persentase_progres": persentaseProgres,
  };
}

class TargetD {
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
  final List<Progres>? progres;

  TargetD({
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
    this.progres,
  });

  factory TargetD.fromJson(String str) => TargetD.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TargetD.fromMap(Map<String, dynamic> json) => TargetD(
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
  final int? userId;
  final int? targetId;
  final String? setoran;
  final DateTime? tanggalSetoran;
  final String? waktuSetoran;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Progres({
    this.id,
    this.userId,
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
    userId: json["user_id"],
    targetId: json["target_id"],
    setoran: (json["setoran"]),
    tanggalSetoran:
        json["tanggal_setoran"] == null
            ? null
            : DateTime.parse(json["tanggal_setoran"]),
    waktuSetoran: json["waktu_setoran"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "target_id": targetId,
    "setoran": setoran,
    "tanggal_setoran": tanggalSetoran?.toIso8601String(),
    "waktu_setoran": waktuSetoran,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
