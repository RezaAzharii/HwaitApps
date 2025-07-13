import 'package:flutter/material.dart';
import 'package:hwait_apps/core/core.dart';

class CostGrid extends StatelessWidget {
  final int ticket;
  final int food;
  final int transport;
  final int others;

  const CostGrid({
    required this.ticket,
    required this.food,
    required this.transport,
    required this.others,
    super.key,
  });

  Widget _buildCostCard(String title, int amount, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              formatCurrency(amount),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        _buildCostCard('Tiket', ticket, Icons.local_activity, Colors.green),
        _buildCostCard('Makanan', food, Icons.restaurant, Colors.orange),
        _buildCostCard(
          'Transport',
          transport,
          Icons.directions_car,
          Colors.blue,
        ),
        _buildCostCard('Lainnya', others, Icons.more_horiz, Colors.purple),
      ],
    );
  }
}
