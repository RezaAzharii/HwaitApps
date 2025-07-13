import 'dart:io';

class TargetRequestModel {
  final String title;
  final int ticket;
  final int food;
  final int transport;
  final int others;
  final String locationName;
  final double latitude;
  final double longitude;
  final File? imageFile;
  final String? imageUrl;

  TargetRequestModel({
    required this.title,
    required this.ticket,
    required this.food,
    required this.transport,
    required this.others,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    this.imageFile,
    this.imageUrl,
  });

  Map<String, String> toFields() {
    return {
      'title': title,
      'ticket': ticket.toString(),
      'food': food.toString(),
      'transport': transport.toString(),
      'others': others.toString(),
      'location_name': locationName,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };
  }
}
