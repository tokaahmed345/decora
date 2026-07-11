import 'dart:io';
import 'package:decora/feature/ai_analyzer/presentation/cubits/cubit/room_analyzer_cubit.dart';
import 'package:decora/feature/ai_analyzer/presentation/widgets/ai_room_analyzer_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiRoomAnalyzerView extends StatelessWidget {
  final File roomImage;
  const AiRoomAnalyzerView({super.key, required this.roomImage});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomAnalyzerCubit()..analyzeRoom(roomImage),
      child: Scaffold(
        body: AiRoomAnalyzerViewBody(roomImage: roomImage)),
    );
  }
}





