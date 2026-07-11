import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/home/domain/entity/home_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<HomeEntity>>> fetchData();
}