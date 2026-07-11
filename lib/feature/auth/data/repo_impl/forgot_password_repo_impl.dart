import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/auth/data/data_source/forgot_remote_data_source.dart';
import 'package:decora/feature/auth/domain/entity/forgot_password_entity.dart';
import 'package:decora/feature/auth/domain/repos/forgot_password_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordRepoImpl implements ForgotPasswordRepo {
  final ForgotRemoteDataSource remoteDataSource;

  ForgotPasswordRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ForgotPasswordEntity>> forgot({
    required String email,
  }) async {
    try {
      final user = await remoteDataSource.resetPassword(email: email);

      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}