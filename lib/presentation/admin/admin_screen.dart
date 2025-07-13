import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hwait_apps/core/core.dart';
import 'package:hwait_apps/data/model/response/recommendation_response_model.dart';
import 'package:hwait_apps/presentation/admin/add_recommendation.dart';
import 'package:hwait_apps/presentation/admin/bloc/adminbloc/admin_screen_bloc.dart';
import 'package:hwait_apps/presentation/admin/detail_recommendation_screen.dart';
import 'package:hwait_apps/presentation/admin/edit_recommendation_screen.dart';
import 'package:hwait_apps/presentation/auth/login_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    context.read<AdminScreenBloc>().add(LoadAdminScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Dashboard Admin',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.darkTealGradientRow,
          ),
        ),
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.logout, color: Colors.white, size: 20),
              ),
              tooltip: 'Logout',
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Konfirmasi Logout'),
                        content: const Text('Apakah Anda yakin ingin logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await _secureStorage.delete(key: 'authToken');
                              if (!mounted) return;
                              context.pushAndRemoveUntil(
                                LoginScreen(),
                                (route) => false,
                              );
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                );
              },
            ),
          ),
        ],
      ),
      body: BlocListener<AdminScreenBloc, AdminScreenState>(
        listener: (context, state) {
          if (state is DeleteRecommendationLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => const Center(
                    child: CircularProgressIndicator(color: Color(0xFF667eea)),
                  ),
            );
          } else {
            if (Navigator.canPop(context)) Navigator.pop(context);

            if (state is DeleteRecommendationSuccess) {
              showCustomSnackBar(
                context,
                message: state.message,
                backgroundColor: AppColors.green,
              );
              context.read<AdminScreenBloc>().add(LoadAdminScreen());
            } else if (state is DeleteRecommendationError) {
              showCustomSnackBar(
                context,
                message: state.message,
                backgroundColor: AppColors.red,
              );
            }
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Daftar Rekomendasi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2c3e50),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF667eea).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: BlocBuilder<AdminScreenBloc, AdminScreenState>(
                        builder: (context, state) {
                          int count = 0;
                          if (state is GetAllRecommendationLoaded) {
                            count = state.allRecommendation.data?.length ?? 0;
                          }
                          return Text(
                            '$count items',
                            style: const TextStyle(
                              color: Color(0xFF667eea),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<AdminScreenBloc, AdminScreenState>(
                    builder: (context, state) {
                      if (state is GetAllRecommendationLoading) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Color(0xFF667eea),
                                strokeWidth: 3,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Memuat data...',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is GetAllRecommendationError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.error_outline,
                                  size: 48,
                                  color: Colors.red.shade400,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Terjadi Kesalahan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.message,
                                style: TextStyle(
                                  color: Colors.red.shade600,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      } else if (state is GetAllRecommendationLoaded) {
                        final List<Recom> data =
                            state.allRecommendation.data ?? [];
                        if (data.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    Icons.inbox_outlined,
                                    size: 48,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Belum Ada Data',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Belum ada rekomendasi yang ditambahkan.',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return RecommendationItemCard(
                              item: item,
                              isHorizontal: false,
                              onTap:
                                  () => context.push(
                                    DetailRecommendationScreen(
                                      id: item.id ?? 0,
                                    ),
                                  ),
                              onEdit:
                                  () => context.push(
                                    EditRecommendationScreen(
                                      id: item.id ?? 0,
                                      recomData: item,
                                    ),
                                  ),
                              onDelete:
                                  () => showDeleteConfirmationDialog(
                                    context,
                                    onConfirm: () {
                                      context.read<AdminScreenBloc>().add(
                                        DeleteRecommendation(item.id ?? 0),
                                      );
                                    },
                                  ),
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667eea).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF667eea),
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
          elevation: 0,
          onPressed: () {
            context.push(AddRecommendationScreen());
          },
        ),
      ),
    );
  }
}
