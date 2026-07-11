import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/core/utils/sharedprefrence.dart';
import 'package:decora/feature/auth/data/data_source/sign_up_remote_data_source.dart';
import 'package:decora/feature/auth/domain/entity/signup_entity.dart';
import 'package:decora/feature/auth/domain/repos/signup_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepoImpl implements SignUpRepo{
    final SignUpRemoteDataSource remoteDataSource;
  final SharedPrefs sharedPrefs;

  SignUpRepoImpl({required this.remoteDataSource, required this.sharedPrefs});
  @override
  Future<Either<Failure, SignUpEntity>> register({required String name, required String email, required String password})async {
 try {
  final user=await remoteDataSource.signUp(name: name, email: email, password: password);
  sharedPrefs.saveUserId(user.id);
  
  sharedPrefs.saveUserName(user.fullName);
  return right(user);

} on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }


  }

}