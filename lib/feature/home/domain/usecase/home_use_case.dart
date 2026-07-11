import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/home/domain/entity/home_entity.dart';
import 'package:decora/feature/home/domain/repos/home_repo.dart';

class HomeUseCase {
  final HomeRepo repo;

  HomeUseCase({required this.repo});

  Future<Either<Failure, List<HomeEntity>>> call() async {
    return await repo.fetchData();
  }
}