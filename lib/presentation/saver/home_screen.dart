import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hwait_apps/core/core.dart';
import 'package:hwait_apps/data/model/response/recommendation_response_model.dart';
import 'package:hwait_apps/presentation/admin/bloc/adminbloc/admin_screen_bloc.dart';
import 'package:hwait_apps/presentation/admin/detail_recommendation_screen.dart';
import 'package:hwait_apps/presentation/auth/login_screen.dart';
import 'package:hwait_apps/presentation/saver/add_target_screen.dart';
import 'package:hwait_apps/presentation/saver/bloc/targetProgres/target_bloc.dart';
import 'package:hwait_apps/presentation/saver/detail_tabungan_screen.dart';
import 'package:hwait_apps/presentation/saver/widget/target_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    context.read<AdminScreenBloc>().add(LoadAdminScreen());
    context.read<TargetBloc>().add(FetchActiveTargets());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Hwait',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.darkTealGradientRow,
          ),
        ),
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.darkTealGradientRow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.rocket_launch, color: Colors.white, size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat datang',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'kamu harus mulai menabung',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Target Tabungan Anda',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                          onPressed: () {
                            context.push(AddTargetScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<TargetBloc, TargetState>(
                    builder: (context, state) {
                      if (state is TargetLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is TargetLoaded) {
                        final targets = state.targets;
                        if (targets.isEmpty) {
                          return const Text("Belum ada tabungan aktif");
                        }
                        return Column(
                          children:
                              targets.map((target) {
                                return SavingsTargetCard(
                                  targetName: target.title ?? '',
                                  currentAmount:
                                      (target.totalSetoran ?? 0).toDouble(),
                                  targetAmount:
                                      (target.totalTarget ?? 0).toDouble(),
                                  onTap: () {
                                    context.push(
                                      DetailTabunganScreen(
                                        targetId: target.id ?? 0,
                                      ),
                                    );
                                    print("Tapped Target ID: ${target.id}");
                                  },
                                );
                              }).toList(),
                        );
                      } else if (state is TargetError) {
                        return Text("Gagal memuat data: ${state.message}");
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<AdminScreenBloc, AdminScreenState>(
                    builder: (context, state) {
                      if (state is GetAllRecommendationLoading) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Color(0xFF667eea),
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

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Rekomendasi untuk Anda',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 220,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final item = data[index];
                                  return RecommendationItemCard(
                                    item: item,
                                    isHorizontal: true,
                                    onTap:
                                        () => context.push(
                                          DetailRecommendationScreen(
                                            id: item.id ?? 0,
                                          ),
                                        ),
                                    onEdit: () {},
                                    onDelete: () {},
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: 0,
        onTap: (index) {
          if (index != 0) {
            NavigationHelper.navigateToHistory(context);
          }
        },
      ),
    );
  }
}
