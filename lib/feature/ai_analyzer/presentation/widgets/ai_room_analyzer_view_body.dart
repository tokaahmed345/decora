
import 'dart:io';

import 'package:decora/feature/ai_analyzer/presentation/cubits/cubit/room_analyzer_cubit.dart';
import 'package:decora/feature/ai_analyzer/presentation/widgets/error_view.dart';
import 'package:decora/feature/ai_analyzer/presentation/widgets/loading_view.dart';
import 'package:decora/feature/ai_analyzer/presentation/widgets/result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiRoomAnalyzerViewBody extends StatelessWidget {
  final File roomImage;
  const AiRoomAnalyzerViewBody({super.key, required this.roomImage});

  @override
  Widget build(BuildContext context) {
   
      return BlocBuilder<RoomAnalyzerCubit, RoomAnalyzerState>(
        builder: (context, state) {
          if (state is RoomAnalyzerLoading || state is RoomAnalyzerInitial) {
            return LoadingView(roomImage: roomImage);
          }
          if (state is RoomAnalyzerFailure) {
            return ErrorView(
              message: state.errorMessage,
              onRetry: () =>
                  context.read<RoomAnalyzerCubit>().analyzeRoom(roomImage),
            );
          }
          final result = (state as RoomAnalyzerSuccess).result;
          return ResultView(roomImage: roomImage, result: result);
        },
      );
    
  }
}
