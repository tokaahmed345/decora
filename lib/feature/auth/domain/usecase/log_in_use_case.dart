import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/auth/domain/entity/log_in_entity.dart';
import 'package:decora/feature/auth/domain/repos/log_in_repo.dart';

class LogInUseCase {
final LogInRepo repo;

  LogInUseCase({required this.repo});

  Future<Either<Failure,LogInEntity>>call({ required String email, required String password,})async{
 return await repo.logIn( email: email,password: password );

  }

}