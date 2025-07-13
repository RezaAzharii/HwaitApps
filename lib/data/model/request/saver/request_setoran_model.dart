import 'dart:convert';

class RequestSetoranModel {
  final int? targetId;
  final int? setoran;
  final DateTime? tanggalSetoran;
  final String? waktuSetoran;

  RequestSetoranModel({
    this.targetId,
    this.setoran,
    this.tanggalSetoran,
    this.waktuSetoran,
  });

  factory RequestSetoranModel.fromJson(String str) =>
      RequestSetoranModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RequestSetoranModel.fromMap(Map<String, dynamic> json) =>
      RequestSetoranModel(
        targetId: json["target_id"],
        setoran: int.tryParse(json["setoran"].toString()),
        tanggalSetoran:
            json["tanggal_setoran"] == null
                ? null
                : DateTime.parse(json["tanggal_setoran"]),
        waktuSetoran: json["waktu_setoran"],
      );

  Map<String, dynamic> toMap() => {
    "target_id": targetId,
    "setoran": setoran,
    "tanggal_setoran": tanggalSetoran?.toString().split(' ').first,
    "waktu_setoran": waktuSetoran,
  };
}
