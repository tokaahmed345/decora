import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/ai_analyzer/domain/entity/room_analyzer_entity.dart';

abstract class RoomAnalyzerRepo {
  Future<Either<Failure, RoomAnalysisEntity>> analyzeRoom(File roomImage);
}