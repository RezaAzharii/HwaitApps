part of 'map_bloc.dart';

sealed class MapState {}

final class MapInitial extends MapState {}

final class MapsReady extends MapState {
  final CameraPosition? initialCamera;
  final Marker? pickedMarker;
  final String? pickedAddress;
  final String? currentAddress;

  MapsReady({
    this.initialCamera,
    this.pickedMarker,
    this.pickedAddress,
    this.currentAddress,
  });

  MapsReady copyWith({
    CameraPosition? initialCamera,
    Marker? pickedMarker,
    String? pickedAddress,
    String? currentAddress,
  }) {
    return MapsReady(
      initialCamera: initialCamera ?? this.initialCamera,
      pickedMarker: pickedMarker,
      pickedAddress: pickedAddress,
      currentAddress: currentAddress ?? this.currentAddress,
    );
  }
}
