import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final String? name;
  final String? lat;
  final String? lng;

  const LocationCard({this.name, this.lat, this.lng, super.key});

  @override
  Widget build(BuildContext context) {
    final double latitude = double.tryParse(lat ?? '0') ?? 0;
    final double longitude = double.tryParse(lng ?? '0') ?? 0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Lokasi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              name ?? '-',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.gps_fixed, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'Lat: ${latitude.toStringAsFixed(6)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.gps_fixed, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'Lng: ${longitude.toStringAsFixed(6)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
