import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwait_apps/core/core.dart';
import 'package:hwait_apps/data/model/request/saver/request_target_model.dart';
import 'package:hwait_apps/presentation/saver/bloc/bloc/add_target_bloc.dart';
import 'package:hwait_apps/presentation/saver/bloc/targetProgres/target_bloc.dart';
import 'package:hwait_apps/presentation/saver/widget/form_target.dart';

class AddTargetScreen extends StatefulWidget {
  const AddTargetScreen({super.key});

  @override
  State<AddTargetScreen> createState() => _AddTargetScreenState();
}

class _AddTargetScreenState extends State<AddTargetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Tambah Target',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.darkTealGradient),
        ),
      ),
      body: BlocListener<AddTargetBloc, AddTargetState>(
        listener: (context, state) async {
          if (state is AddTargetLoading) {
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

            if (state is AddTargetSuccess) {
              showCustomSnackBar(
                context,
                message: state.message,
                backgroundColor: Colors.green,
              );
              context.read<TargetBloc>().add(FetchActiveTargets());
              await Future.delayed(const Duration(milliseconds: 100));
              Navigator.pop(context);
            }

            if (state is AddTargetError) {
              showCustomSnackBar(
                context,
                message: state.error,
                backgroundColor: Colors.red,
              );
              context.read<TargetBloc>().add(FetchActiveTargets());
              await Future.delayed(const Duration(milliseconds: 100));
              Navigator.pop(context);
            }
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: FormTarget(
            onSubmit: (TargetRequestModel formData) {
              final targetRequest = TargetRequestModel(
                title: formData.title,
                ticket: formData.ticket,
                food: formData.food,
                transport: formData.transport,
                others: formData.others,
                locationName: formData.locationName,
                latitude: formData.latitude,
                longitude: formData.longitude,
                imageFile: formData.imageFile,
              );
              context.read<AddTargetBloc>().add(SubmitAddTarget(targetRequest));
            },
          ),
        ),
      ),
    );
  }
}
