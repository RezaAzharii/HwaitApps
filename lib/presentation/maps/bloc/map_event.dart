part of 'map_bloc.dart';

sealed class MapEvent {}

class LoadCurrentLocation extends MapEvent {}
class PickLocation extends MapEvent{
  final LatLng latLng;
  PickLocation(this.latLng);
}

class ClearPickedLocation extends MapEvent{}