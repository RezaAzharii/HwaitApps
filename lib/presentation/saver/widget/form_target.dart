import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hwait_apps/data/model/request/saver/request_target_model.dart';
import 'package:hwait_apps/presentation/maps/map_screen.dart'; 
import 'package:image_picker/image_picker.dart';
import 'package:hwait_apps/core/core.dart'; 

class FormTarget extends StatefulWidget {
  final void Function(TargetRequestModel) onSubmit;
  final TargetRequestModel? initialData;
  final bool isEdit;

  const FormTarget({
    super.key,
    required this.onSubmit,
    this.initialData,
    this.isEdit = false,
  });

  @override
  State<FormTarget> createState() => _FormTargetState();
}

class _FormTargetState extends State<FormTarget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController ticketController;
  late TextEditingController foodController;
  late TextEditingController transportController;
  late TextEditingController othersController;
  late TextEditingController locationNameController;
  late TextEditingController latitudeController;
  late TextEditingController longitudeController;

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;
    titleController = TextEditingController(text: data?.title ?? '');
    ticketController = TextEditingController(
      text: data != null && data.ticket != 0 ? data.ticket.toString() : '',
    );
    foodController = TextEditingController(
      text: data != null && data.food != 0 ? data.food.toString() : '',
    );
    transportController = TextEditingController(
      text: data != null && data.transport != 0 ? data.transport.toString() : '',
    );
    othersController = TextEditingController(
      text: data != null && data.others != 0 ? data.others.toString() : '',
    );
    locationNameController = TextEditingController(
      text: data?.locationName ?? '',
    );
    latitudeController = TextEditingController(
      text: data?.latitude.toString() ?? '0.0',
    );
    longitudeController = TextEditingController(
      text: data?.longitude.toString() ?? '0.0', 
    );
    _selectedImage = data?.imageFile;
  }

  @override
  void dispose() {
    titleController.dispose();
    ticketController.dispose();
    foodController.dispose();
    transportController.dispose();
    othersController.dispose();
    locationNameController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  int get totalEstimated {
    final ticket = int.tryParse(ticketController.text) ?? 0;
    final food = int.tryParse(foodController.text) ?? 0;
    final transport = int.tryParse(transportController.text) ?? 0;
    final others = int.tryParse(othersController.text) ?? 0;
    return ticket + food + transport + others;
  }
  
  Future<void> _showImagePickerOptions() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.camera,
                  color: AppColors.blueGradientEnd,
                ),
                title: const Text('Ambil Foto dari Kamera'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: AppColors.blueGradientEnd,
                ),
                title: const Text('Pilih dari Galeri'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (source != null) {
      await _pickImage(source);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: source);

      if (picked != null) {
        setState(() {
          _selectedImage = File(picked.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memilih gambar: ${e.toString()}')),
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (latitudeController.text == '0.0' || longitudeController.text == '0.0' || locationNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mohon pilih lokasi dari peta terlebih dahulu.')),
        );
        return;
      }

      final data = TargetRequestModel(
        title: titleController.text,
        ticket: int.tryParse(ticketController.text) ?? 0,
        food: int.tryParse(foodController.text) ?? 0,
        transport: int.tryParse(transportController.text) ?? 0,
        others: int.tryParse(othersController.text) ?? 0,
        locationName: locationNameController.text,
        latitude: double.tryParse(latitudeController.text) ?? 0.0,
        longitude: double.tryParse(longitudeController.text) ?? 0.0,
        imageFile: _selectedImage,
      );
      widget.onSubmit(data);
    }
  }

  void _pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MapScreen()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        locationNameController.text = result['location_name'] ?? '';
        latitudeController.text = result['latitude'].toString();
        longitudeController.text = result['longitude'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            title: 'Informasi Dasar',
            icon: Icons.info_outline,
          ),
          CustomTextformField(
            controller: titleController,
            label: 'Judul Target',
            prefixIcon: Icons.title,
            validator: (v) => v!.isEmpty ? 'Judul target wajib diisi' : null,
          ),

          const SectionHeader(
            title: 'Estimasi Biaya',
            icon: Icons.account_balance_wallet,
          ),
          CostInputField(
            controller: ticketController,
            label: 'Tiket',
            icon: Icons.confirmation_number,
            color: Colors.lightBlue,
            onChanged: (_) => setState(() {}),
          ),
          CostInputField(
            controller: foodController,
            label: 'Makanan',
            icon: Icons.restaurant,
            color: Colors.lightBlue,
            onChanged: (_) => setState(() {}),
          ),
          CostInputField(
            controller: transportController,
            label: 'Transportasi',
            icon: Icons.directions_car,
            color: Colors.lightBlue,
            onChanged: (_) => setState(() {}),
          ),
          CostInputField(
            controller: othersController,
            label: 'Lain-lain',
            icon: Icons.more_horiz,
            color: Colors.lightBlue,
            onChanged: (_) => setState(() {}),
          ),
          if (totalEstimated > 0)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppColors.darkTealGradientRow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Estimasi:',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Rp ${formatCurrency(totalEstimated)}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          const SectionHeader(title: 'Lokasi', icon: Icons.location_on),
          CustomTextformField(
            controller: locationNameController,
            label: 'Nama Lokasi',
            prefixIcon: Icons.map,
            readOnly: true, 
            onTap: _pickLocation,
            validator: (v) => v!.isEmpty ? 'Nama lokasi wajib diisi dari peta' : null,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextformField(
                  controller: latitudeController,
                  label: 'Latitude',
                  prefixIcon: Icons.my_location,
                  readOnly: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextformField(
                  controller: longitudeController,
                  label: 'Longitude',
                  prefixIcon: Icons.my_location,
                  readOnly: true,
                ),
              ),
            ],
          ),
          const SectionHeader(title: 'Gambar', icon: Icons.image),
          GestureDetector(
            onTap: _showImagePickerOptions,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : widget.initialData?.imageUrl != null && widget.initialData!.imageUrl!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.initialData!.imageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) => const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text('Gagal memuat gambar', style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate,
                                size: 40,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tap untuk memilih gambar',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 56,
            child: Button.filled(
              onPressed: _submitForm,
              icon: const Icon(Icons.save),
              label: widget.isEdit ? 'Simpan Perubahan' : 'Simpan Target', 
            ),
          ),
        ],
      ),
    );
  }
}