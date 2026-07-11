import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';

abstract class UploadImageRepo {
  Future<Either<Failure, String>> uploadUserProfileImage(
      String userId, File file);

  Future<Either<Failure, Map<String, dynamic>?>> getUserData(String userId);
}