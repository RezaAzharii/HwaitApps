import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/core/core.dart';
import 'package:hwait_apps/data/model/request/admin/recommendation_request_model.dart';
import 'package:hwait_apps/data/model/response/recommendation_response_model.dart';
import 'package:hwait_apps/presentation/admin/bloc/adminbloc/admin_screen_bloc.dart';
import 'package:hwait_apps/presentation/admin/bloc/editRecom/edit_recommendation_bloc.dart';
import 'package:hwait_apps/presentation/admin/widget/recomendation_form.dart';

class EditRecommendationScreen extends StatelessWidget {
  final int id;
  final Recom recomData;

  const EditRecommendationScreen({
    super.key,
    required this.id,
    required this.recomData,
  });

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
      body: BlocListener<EditRecommendationBloc, EditRecommendationState>(
        listener: (context, state) async {
          if (state is UpdateRecommendationLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.gradientStart,
                    ),
                  ),
            );
          } else {
            if (Navigator.canPop(context)) Navigator.pop(context);

            if (state is UpdateRecommendationSuccess) {
              showCustomSnackBar(
                context,
                message: state.message,
                backgroundColor: AppColors.green,
              );
              context.read<AdminScreenBloc>().add(LoadAdminScreen());
              Navigator.pop(context);
            }

            if (state is UpdateRecommendationError) {
              showCustomSnackBar(
                context,
                message: state.message,
                backgroundColor: AppColors.red,
              );
            }
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: RecommendationForm(
            isEdit: true,
            initialData: RecommendationFormData(
              title: recomData.title ?? '',
              description: recomData.description ?? '',
              ticket: recomData.ticket ?? 0,
              food: recomData.food ?? 0,
              transport: recomData.transport ?? 0,
              others: recomData.others ?? 0,
              locationName: recomData.locationName ?? '',
              latitude: recomData.latitude ?? 0.0,
              longitude: recomData.longitude ?? 0.0,
              imageFile: null,
              imageUrl:
                  recomData.imagePath != null
                      ? 'http://192.168.0.114:8000/storage/${recomData.imagePath}'
                      : null,
            ),
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

              context.read<EditRecommendationBloc>().add(
                UpdateRecommendation(id: id, updatedData: model.toFields()),
              );
            },
          ),
        ),
      ),
    );
  }
}
