part of 'map_bloc.dart';

class LocationData {
  final double latitude;
  final double longitude;
  final String address;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

sealed class MapState {}

final class MapsReady extends MapState {
  final CameraPosition? initialCamera;
  final Marker? pickedMarker;
  final LocationData? pickedLocation;
  final String? currentAddress;

  MapsReady({
    this.initialCamera,
    this.pickedMarker,
    this.pickedLocation,
    this.currentAddress,
  });

  MapsReady copyWith({
    CameraPosition? initialCamera,
    Marker? pickedMarker,
    bool updatePickedMarker = false,
    LocationData? pickedLocation,
    bool updatePickedLocation = false,
    String? currentAddress,
  }) {
    return MapsReady(
      initialCamera: initialCamera ?? this.initialCamera,
      pickedMarker: updatePickedMarker ? pickedMarker : this.pickedMarker,
      pickedLocation: updatePickedLocation ? pickedLocation : this.pickedLocation,
      currentAddress: currentAddress ?? this.currentAddress,
    );
  }
}
