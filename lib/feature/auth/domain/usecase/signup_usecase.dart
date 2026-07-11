import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/auth/domain/entity/signup_entity.dart';
import 'package:decora/feature/auth/domain/repos/signup_repo.dart';

class SignUpUseCase {
final SignUpRepo repo;

  SignUpUseCase({required this.repo});

  Future<Either<Failure,SignUpEntity>>call({required String name, required String email,required String password})async{
 return await repo.register(name: name, email: email, password: password);

  }

}