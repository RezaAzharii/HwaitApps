import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/core/components/components.dart';
import 'package:hwait_apps/core/extensions/build_context_ext.dart';
import 'package:hwait_apps/presentation/saver/bloc/riwayatTabungan/riwayat_tabungan_bloc.dart';
import 'package:hwait_apps/core/constants/colors.dart';
import 'package:hwait_apps/presentation/saver/detail_tabungan_screen.dart';

class RiwayatTabunganScreen extends StatefulWidget {
  const RiwayatTabunganScreen({super.key});

  @override
  State<RiwayatTabunganScreen> createState() => _RiwayatTabunganScreenState();
}

class _RiwayatTabunganScreenState extends State<RiwayatTabunganScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RiwayatTabunganBloc>().add(FetchRiwayatTabungan());
  }

  Color _getStatusColor(String? status) {
    return Colors.green;
  }

  IconData _getStatusIcon(String? status) {
    return Icons.check_circle;
  }

  int parseAmount(dynamic value) {
    return int.tryParse(
          double.tryParse(value?.toString() ?? '0')?.toStringAsFixed(0) ?? '0',
        ) ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueLight,
      appBar: AppBar(
        title: const Text(
          'Riwayat Tabungan',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.darkTealGradientRow,
          ),
        ),
      ),
      body: BlocBuilder<RiwayatTabunganBloc, RiwayatTabunganState>(
        builder: (context, state) {
          if (state is RiwayatTabunganLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          } else if (state is RiwayatTabunganLoaded) {
            if (state.riwayat.isEmpty) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.savings_outlined,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Belum ada data tabungan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Mulai buat target tabungan pertama Anda untuk melihat riwayat di sini',
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<RiwayatTabunganBloc>().add(FetchRiwayatTabungan());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.riwayat.length,
                itemBuilder: (context, index) {
                  final item = state.riwayat[index];
                  final statusColor = _getStatusColor(item.status);
                  final statusIcon = _getStatusIcon(item.status);
                  final total =
                      parseAmount(item.ticket) +
                      parseAmount(item.food) +
                      parseAmount(item.transport) +
                      parseAmount(item.others);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        context.push(
                          DetailTabunganScreen(targetId: item.id ?? 0),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.task_alt,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title ?? 'Target Tabungan',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        statusIcon,
                                        size: 16,
                                        color: statusColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Selesai',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: statusColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Total Tabungan ${formatCurrency(total)}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey[400],
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
