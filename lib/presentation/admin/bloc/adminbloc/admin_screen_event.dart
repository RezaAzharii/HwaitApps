part of 'admin_screen_bloc.dart';

sealed class AdminScreenEvent {}

class LoadAdminScreen extends AdminScreenEvent {}

class DeleteRecommendation extends AdminScreenEvent {
  final int id;

  DeleteRecommendation(this.id);
}

