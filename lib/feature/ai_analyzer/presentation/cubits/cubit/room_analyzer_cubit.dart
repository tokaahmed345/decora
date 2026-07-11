import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/ai_analyzer/data/repo_impl/repo_analyzer_repo_impl.dart';
import 'package:decora/feature/ai_analyzer/domain/entity/room_analyzer_entity.dart';
import 'package:decora/feature/ai_analyzer/domain/use_case/room_analyzer_use_case.dart';
import 'package:equatable/equatable.dart';

part 'room_analyzer_state.dart';

class RoomAnalyzerCubit extends Cubit<RoomAnalyzerState> {
  RoomAnalyzerCubit() : super(RoomAnalyzerInitial());

 Future<void> analyzeRoom(File roomImage) async {
    emit(RoomAnalyzerLoading());
    final result = await RoomAnalyzerUseCase(
      repo: getIt.get<RoomAnalyzerRepoImpl>(),
    ).call(roomImage);

    result.fold(
      (fail) => emit(RoomAnalyzerFailure(errorMessage: fail.message)),
      (analysis) => emit(RoomAnalyzerSuccess(result: analysis)),
    );
  }



}


