import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/core/components/components.dart';
import 'package:hwait_apps/core/constants/colors.dart';
import 'package:hwait_apps/presentation/saver/bloc/detailTarget/detail_target_bloc.dart';
import 'package:hwait_apps/presentation/saver/widget/detailTarget/cost_grid.dart';
import 'package:hwait_apps/presentation/saver/widget/detailTarget/estimation_box.dart';
import 'package:hwait_apps/presentation/saver/widget/detailTarget/image_header.dart';
import 'package:hwait_apps/presentation/saver/widget/detailTarget/location_card.dart';
import 'package:hwait_apps/presentation/saver/widget/detailTarget/progres_section.dart';
import 'package:hwait_apps/presentation/saver/widget/detailTarget/setoran.dart';

class DetailTabunganScreen extends StatefulWidget {
  final int targetId;
  const DetailTabunganScreen({required this.targetId, super.key});

  @override
  State<DetailTabunganScreen> createState() => _DetailTabunganScreenState();
}

class _DetailTabunganScreenState extends State<DetailTabunganScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailTargetBloc>().add(FetchDetailTarget(widget.targetId));
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
          'Detail Target',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.darkTealGradientRow,
          ),
        ),
      ),
      body: BlocBuilder<DetailTargetBloc, DetailTargetState>(
        builder: (context, state) {
          if (state is DetailTargetLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailTargetLoaded) {
            final target = state.target;
            final total =
                parseAmount(target.ticket) +
                parseAmount(target.food) +
                parseAmount(target.transport) +
                parseAmount(target.others);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageHeader(target.imagePath, target.title),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ProgressSection(
                          current: state.totalSetoran.toDouble(),
                          targetAmount: state.totalTarget.toDouble(),
                        ),
                        const SizedBox(height: 18),
                        ElevatedButton.icon(
                          onPressed:
                              () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder:
                                    (context) => SetoranBottomSheet(
                                      targetId: widget.targetId,
                                    ),
                              ),
                          icon: const Icon(Icons.add),
                          label: const Text('Tambah Setoran'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 18),
                        if (target.locationName != null)
                          LocationCard(
                            name: target.locationName,
                            lat: target.latitude?.toString(),
                            lng: target.longitude?.toString(),
                          ),
                        const SizedBox(height: 20),
                        CostGrid(
                          ticket: parseAmount(target.ticket),
                          food: parseAmount(target.food),
                          transport: parseAmount(target.transport),
                          others: parseAmount(target.others),
                        ),
                        const SizedBox(height: 20),
                        EstimationBox(total),
                        const SizedBox(height: 24),
                        if (target.progres != null &&
                            target.progres!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 20,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Riwayat Setoran',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 280,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: target.progres!.length,
                                    separatorBuilder:
                                        (context, index) => Divider(
                                          height: 1,
                                          color: Colors.grey[200],
                                          indent: 16,
                                          endIndent: 16,
                                        ),
                                    itemBuilder: (context, index) {
                                      final p = target.progres![index];
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.green.withOpacity(
                                                  0.1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.savings,
                                                color: Colors.green[600],
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Rp ${p.setoran}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    '${p.tanggalSetoran?.toLocal().toString().split(' ')[0] ?? ''} • ${p.waktuSetoran ?? ''}',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right,
                                              color: Colors.grey[400],
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        else ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 20,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Riwayat Setoran',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(
                                        Icons.savings_outlined,
                                        size: 40,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Belum ada setoran',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Mulai menabung untuk mencapai target Anda',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DetailTargetError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: 1,
        onTap: (index) {
          if (index != 1) {
            NavigationHelper.navigateToHistory(context);
          }
        },
      ),
    );
  }
}
