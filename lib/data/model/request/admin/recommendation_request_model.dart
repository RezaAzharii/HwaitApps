import 'dart:io';

class RecommendationRequestModel {
  final String title;
  final int ticket;
  final int food;
  final int transport;
  final int others;
  final String locationName;
  final double latitude;
  final double longitude;
  final String description;
  final File? imageFile;

  RecommendationRequestModel({
    required this.title,
    required this.ticket,
    required this.food,
    required this.transport,
    required this.others,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.description,
    this.imageFile,
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
      'description': description,
    };
  }
}
