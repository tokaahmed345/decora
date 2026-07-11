import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:decora/feature/profile/data/domain/repo/upload_image_repo.dart';
import 'package:equatable/equatable.dart';

part 'image_profile_state.dart';

class ImageProfileCubit extends Cubit<ImageProfileState> {
  final UploadImageRepo repository;

  ImageProfileCubit(this.repository) : super(ImageProfileInitial());

  Future<void> getSavedImage(String userId) async {
    emit(ImageProfileLoading());

    final result = await repository.getUserData(userId);

    result.fold(
      (failure) =>
          emit(ImageProfileFailure(errorMessage: failure.message)),
      (data) {

        final imageUrl = data?['imageUrl'] as String? ?? '';
        final name = data?['name'] as String? ?? '';
        emit(ImageProfileSuccess(imageUrl: imageUrl, name: name));
      },
    );
  }
Future<void> uploadImage(String userId, File file) async {
  final currentName = state is ImageProfileSuccess
      ? (state as ImageProfileSuccess).name
      : '';
  final currentUrl = state is ImageProfileSuccess
      ? (state as ImageProfileSuccess).imageUrl
      : null;

  emit(ImageProfileLoading(name: currentName, imageUrl: currentUrl));

  final result = await repository.uploadUserProfileImage(userId, file);

  result.fold(
    (failure) => emit(ImageProfileFailure(errorMessage: failure.message)),
    (imageUrl) => emit(ImageProfileSuccess(imageUrl: imageUrl, name: currentName)),
  );
}
}