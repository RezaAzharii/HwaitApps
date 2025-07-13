import 'package:flutter/material.dart';
import 'package:hwait_apps/core/components/currency_utils.dart';
import 'package:hwait_apps/data/model/response/recommendation_response_model.dart';

class RecommendationItemCard extends StatelessWidget {
  final Recom item;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isHorizontal;

  const RecommendationItemCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'http://192.168.1.7:8000/storage/${item.imagePath ?? ''}';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: isHorizontal ? 280 : double.infinity,
        margin: EdgeInsets.only(
          bottom: isHorizontal ? 0 : 16,
          right: isHorizontal ? 16 : 0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                imageUrl,
                height: isHorizontal ? 120 : 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: isHorizontal ? 120 : 140,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title ?? 'Tidak ada judul',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: isHorizontal ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF27ae60).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 18,
                          color: Color(0xFF27ae60),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'Rp ${formatCurrency(item.totalEstimated ?? 0)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF27ae60),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isHorizontal) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: onEdit,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: onDelete,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
