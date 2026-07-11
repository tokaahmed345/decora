import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/auth/domain/entity/forgot_password_entity.dart';
import 'package:decora/feature/auth/domain/repos/forgot_password_repo.dart';

class ForgotPasswordUseCase {
final ForgotPasswordRepo repo;

  ForgotPasswordUseCase({required this.repo});

  Future<Either<Failure,ForgotPasswordEntity>>call({ required String email,})async{
 return await repo.forgot( email: email, );

  }

}