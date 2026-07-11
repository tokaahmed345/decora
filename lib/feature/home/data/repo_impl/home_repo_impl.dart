import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:decora/feature/home/domain/entity/home_entity.dart';
import 'package:decora/feature/home/domain/repos/home_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HomeEntity>>> fetchData() async {
    try {
      final remoteData = await remoteDataSource.fetchData();
      return right(remoteData);
    }on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}

