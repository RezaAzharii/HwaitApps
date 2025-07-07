import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapsReady()) {
    on<LoadCurrentLocation>((event, emit) async {
      try {
        if (!await Geolocator.isLocationServiceEnabled()) {
          throw 'Location service belum aktif';
        }

        LocationPermission perm = await Geolocator.checkPermission();
        if (perm == LocationPermission.denied) {
          perm = await Geolocator.requestPermission();
          if (perm == LocationPermission.denied) {
            throw 'Izin lokasi ditolak';
          }
        }
        if (perm == LocationPermission.deniedForever) {
          throw 'Izin lokasi ditolak permanen';
        }

        final pos = await Geolocator.getCurrentPosition();
        final camera = CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 16,
        );

        final placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
        final p = placemarks.first;
        final currentAddress = '${p.name}, ${p.locality}, ${p.country}';

        emit((state as MapsReady).copyWith(
          initialCamera: camera,
          currentAddress: currentAddress,
        ));
      } catch (e) {
        emit((state as MapsReady).copyWith(
          initialCamera: const CameraPosition(target: LatLng(0, 0), zoom: 2),
        ));
      }
    });

    on<PickLocation>((event, emit) async {
      final latlng = event.latLng;
      final placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
      final p = placemarks.first;

      final marker = Marker(
        markerId: const MarkerId('picked'),
        position: latlng,
        infoWindow: InfoWindow(
          title: p.name?.isEmpty == true ? 'Lokasi Dipilih' : p.name,
          snippet: '${p.street}, ${p.locality}',
        ),
      );

      final address = '${p.name}, ${p.street}, ${p.locality}, ${p.country}, ${p.postalCode}';

      emit((state as MapsReady).copyWith(
        pickedMarker: marker,
        pickedAddress: address,
      ));
    });

    on<ClearPickedLocation>((event, emit) {
      emit((state as MapsReady).copyWith(
        pickedMarker: null,
        pickedAddress: null,
      ));
    });
  }
}
