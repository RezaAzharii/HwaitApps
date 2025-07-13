import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/data/repository/auth_repository.dart';
import 'package:hwait_apps/data/repository/recommendation_repository.dart';
import 'package:hwait_apps/data/repository/setoran_repository.dart';
import 'package:hwait_apps/data/repository/target_repository.dart';
import 'package:hwait_apps/presentation/admin/bloc/addRecom/add_recommendation_bloc.dart';
import 'package:hwait_apps/presentation/admin/bloc/adminbloc/admin_screen_bloc.dart';
import 'package:hwait_apps/presentation/admin/bloc/detailRecom/detail_recommendation_bloc.dart';
import 'package:hwait_apps/presentation/admin/bloc/editRecom/edit_recommendation_bloc.dart';
import 'package:hwait_apps/presentation/auth/bloc/login/login_bloc.dart';
import 'package:hwait_apps/presentation/auth/bloc/register/register_bloc.dart';
import 'package:hwait_apps/presentation/auth/login_screen.dart';
import 'package:hwait_apps/presentation/maps/bloc/map_bloc.dart';
import 'package:hwait_apps/presentation/saver/bloc/bloc/add_target_bloc.dart';
import 'package:hwait_apps/presentation/saver/bloc/detailTarget/detail_target_bloc.dart';
import 'package:hwait_apps/presentation/saver/bloc/riwayatTabungan/riwayat_tabungan_bloc.dart';
import 'package:hwait_apps/presentation/saver/bloc/setoran/setoran_bloc.dart';
import 'package:hwait_apps/presentation/saver/bloc/targetProgres/target_bloc.dart';
import 'package:hwait_apps/service/service_http_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => LoginBloc(
                authRepository: AuthRepository(ServiceHttpClient()),
              ),
        ),
        BlocProvider(
          create:
              (context) => RegisterBloc(
                authRepository: AuthRepository(ServiceHttpClient()),
              ),
        ),
        BlocProvider(
          create:
              (context) => AdminScreenBloc(
                RecommendationRepository(ServiceHttpClient()),
              ),
        ),
        BlocProvider(create: (context) => MapBloc()),
        BlocProvider(
          create:
              (context) => AddRecommendationBloc(
                RecommendationRepository(ServiceHttpClient()),
              ),
        ),
        BlocProvider(
          create:
              (context) => DetailRecommendationBloc(
                RecommendationRepository(ServiceHttpClient()),
              ),
        ),
        BlocProvider(
          create:
              (context) => EditRecommendationBloc(
                RecommendationRepository(ServiceHttpClient()),
              ),
        ),
        BlocProvider(
          create:
              (context) => TargetBloc(
                targetRepository: TargetRepository(ServiceHttpClient()),
              ),
        ),
        BlocProvider(
          create:
              (context) =>
                  DetailTargetBloc(TargetRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create:
              (context) => AddTargetBloc(TargetRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create:
              (context) => SetoranBloc(
                SetoranRepository(httpClient: ServiceHttpClient()),
              ),
        ),
        BlocProvider(
          create:
              (context) =>
                  RiwayatTabunganBloc(TargetRepository(ServiceHttpClient())),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
