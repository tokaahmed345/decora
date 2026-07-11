import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/ai_analyzer/domain/entity/room_analyzer_entity.dart';
import 'package:decora/feature/ai_analyzer/domain/repo/room_analyzer_repo.dart';

class RoomAnalyzerUseCase {
  final RoomAnalyzerRepo repo;

  RoomAnalyzerUseCase({required this.repo});

  Future<Either<Failure, RoomAnalysisEntity>> call(File roomImage) async {
    return await repo.analyzeRoom(roomImage);
  }
}