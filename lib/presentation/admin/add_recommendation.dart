import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/core/core.dart';
import 'package:hwait_apps/data/model/request/admin/recommendation_request_model.dart';
import 'package:hwait_apps/presentation/admin/bloc/addRecom/add_recommendation_bloc.dart';
import 'package:hwait_apps/presentation/admin/bloc/adminbloc/admin_screen_bloc.dart';
import 'package:hwait_apps/presentation/admin/widget/recomendation_form.dart';

class AddRecommendationScreen extends StatelessWidget {
  const AddRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Tambah Rekomendasi',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.darkTealGradientRow,
          ),
        ),
      ),
      body: BlocListener<AddRecommendationBloc, AddRecommendationState>(
        listener: (context, state) async {
          if (state is AddRecommendationLoading) {
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

            if (state is AddRecommendationSuccess) {
              showCustomSnackBar(
                context,
                message: state.message,
                backgroundColor: Colors.green,
              );
              context.read<AdminScreenBloc>().add(LoadAdminScreen());
              await Future.delayed(const Duration(milliseconds: 100));
              Navigator.pop(context);
            }

            if (state is AddRecommendationError) {
              showCustomSnackBar(
                context,
                message: state.message,
                backgroundColor: Colors.red,
              );
            }
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: RecommendationForm(
            onSubmit: (formData) {
              final model = RecommendationRequestModel(
                title: formData.title,
                description: formData.description,
                ticket: formData.ticket,
                food: formData.food,
                transport: formData.transport,
                others: formData.others,
                locationName: formData.locationName,
                latitude: formData.latitude,
                longitude: formData.longitude,
                imageFile: formData.imageFile,
              );

              context.read<AddRecommendationBloc>().add(
                SubmitAddRecommendation(model),
              );
            },
          ),
        ),
      ),
    );
  }
}
