 import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/auth/domain/entity/log_in_entity.dart';

abstract class LogInRepo{
  Future<Either<Failure,LogInEntity>>logIn({ required String email, required String password});
 }