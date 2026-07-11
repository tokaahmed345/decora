import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/core/utils/sharedprefrence.dart';
import 'package:decora/feature/auth/data/data_source/log_in_remote_data_source.dart';
import 'package:decora/feature/auth/domain/entity/log_in_entity.dart';
import 'package:decora/feature/auth/domain/repos/log_in_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInRepoImpl implements LogInRepo{
    final LogInRemoteDataSource remoteDataSource;
  final SharedPrefs sharedPrefs;

  LogInRepoImpl({required this.remoteDataSource, required this.sharedPrefs});
  @override
  Future<Either<Failure, LogInEntity>> logIn({ required String email, required String password})async {
 try {
  final user=await remoteDataSource.logIn( email: email, password: password);
  sharedPrefs.saveUserId(user.id);
  
  return right(user);

} on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }


  }
}