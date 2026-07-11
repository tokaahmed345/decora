 import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/auth/domain/entity/signup_entity.dart';

abstract class SignUpRepo{
  Future<Either<Failure,SignUpEntity>>register({required String name, required String email,required String password});
 }