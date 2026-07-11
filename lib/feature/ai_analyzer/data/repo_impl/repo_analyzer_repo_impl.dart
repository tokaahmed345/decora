import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:decora/core/utils/failure/failure.dart';
import 'package:decora/feature/ai_analyzer/data/data_source/room_analyzer_data_source.dart';
import 'package:decora/feature/ai_analyzer/domain/entity/room_analyzer_entity.dart';
import 'package:decora/feature/ai_analyzer/domain/repo/room_analyzer_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoomAnalyzerRepoImpl implements RoomAnalyzerRepo {
  final AiSuggestionDataSource aiSuggestionDataSource;

  RoomAnalyzerRepoImpl({required this.aiSuggestionDataSource});

  @override
  Future<Either<Failure, RoomAnalysisEntity>> analyzeRoom(File roomImage) async {
    try {
      final result = await aiSuggestionDataSource.getSuggestions(roomImage);
      return right(result);
    } on FirebaseAuthException catch (e) {
      return Left(Failure.fromFirebaseAuthCode(e.code));
    } catch (e) {
      return Left(Failure('Unexpected error: ${e.toString()}'));
    }
  }
}