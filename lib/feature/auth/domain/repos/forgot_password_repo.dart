 import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/auth/domain/entity/forgot_password_entity.dart';

abstract class ForgotPasswordRepo{
  Future<Either<Failure,ForgotPasswordEntity>>forgot({required String email});
 }