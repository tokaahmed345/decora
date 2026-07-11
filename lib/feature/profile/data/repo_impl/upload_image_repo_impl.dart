import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/profile/data/data_source/upload_profile_image_remote_data_source.dart';
import 'package:decora/feature/profile/data/domain/repo/upload_image_repo.dart';

class UploadImageRepoImpl implements UploadImageRepo {
  final UploadProfileImageRemoteDataSource remoteDataSource;

  UploadImageRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> uploadUserProfileImage(
      String userId, File file) async {
    try {
      final url = await remoteDataSource.uploadUserImage(userId, file);
      return Right(url);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> getUserData(
      String userId) async {
    try {
      final data = await remoteDataSource.getUserData(userId);
      return Right(data);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}