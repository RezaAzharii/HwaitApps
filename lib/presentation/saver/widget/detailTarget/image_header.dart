import 'dart:ui';

import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  final String? imagePath;
  final String? title;

  const ImageHeader(this.imagePath, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child:
                imagePath != null
                    ? Image.network(
                      'http://192.168.1.7:8000/storage/$imagePath',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const _ImageError(),
                    )
                    : const _ImageError(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _ImageOverlay(title ?? 'Tanpa Judul'),
          ),
        ],
      ),
    );
  }
}

class _ImageOverlay extends StatelessWidget {
  final String title;

  const _ImageOverlay(this.title);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.white.withOpacity(0.1),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
          SizedBox(height: 8),
          Text('Gambar tidak tersedia', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
