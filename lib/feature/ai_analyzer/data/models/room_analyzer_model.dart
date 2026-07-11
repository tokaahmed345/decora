import 'package:decora/feature/ai_analyzer/domain/entity/room_analyzer_entity.dart';

class RoomAnalysisModel extends RoomAnalysisEntity {
  RoomAnalysisModel({
    required super.dominantColors,
    required super.style,
    required super.suggestions,
  });

  factory RoomAnalysisModel.fromJson(Map<String, dynamic> json) {
    return RoomAnalysisModel(
      dominantColors: List<String>.from(json['dominantColors'] ?? []),
      style: json['style'] ?? '',
      suggestions: (json['suggestions'] as List)
          .map((s) => DecorSuggestionEntity(
                category: s['category'] ?? '',
                text: s['text'] ?? '',
              ))
          .toList(),
    );
  }
}