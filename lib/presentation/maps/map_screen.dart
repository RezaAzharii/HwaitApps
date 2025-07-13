import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bloc/map_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(LoadCurrentLocation());
  }

  void _confirmSelection(BuildContext context, MapsReady state) {
    if (state.pickedMarker == null || state.pickedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Silakan pilih lokasi terlebih dahulu."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Konfirmasi Alamat'),
            content: Text(state.pickedLocation!.address),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, {
                    'location_name': state.pickedLocation!.address,
                    'latitude': state.pickedLocation!.latitude,
                    'longitude': state.pickedLocation!.longitude,
                  });
                },
                child: const Text('Pilih'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Lokasi')),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is! MapsReady || state.initialCamera == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: state.initialCamera!,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers:
                    state.pickedMarker != null ? {state.pickedMarker!} : {},
                onMapCreated: (controller) => _controller.complete(controller),
                onTap: (latlng) {
                  context.read<MapBloc>().add(PickLocation(latlng));
                },
              ),
              Positioned(
                top: 20,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    state.currentAddress ?? 'Mencari Lokasi...',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              if (state.pickedLocation != null)
                Positioned(
                  bottom: 120,
                  left: 16,
                  right: 16,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        state.pickedLocation!.address,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is! MapsReady || state.pickedLocation == null) {
            return const SizedBox.shrink();
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: 'confirm',
                onPressed: () => _confirmSelection(context, state),
                label: const Text('Pilih Lokasi'),
                icon: const Icon(Icons.check),
              ),
              const SizedBox(height: 8),
              FloatingActionButton.extended(
                heroTag: 'clear',
                onPressed:
                    () => context.read<MapBloc>().add(ClearPickedLocation()),
                label: const Text('Hapus Marker'),
                icon: const Icon(Icons.clear),
              ),
            ],
          );
        },
      ),
    );
  }
}
