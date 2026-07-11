class RoomAnalysisEntity {
  final List<String> dominantColors; 
  final String style;
  final List<DecorSuggestionEntity> suggestions;

  RoomAnalysisEntity({
    required this.dominantColors,
    required this.style,
    required this.suggestions,
  });
}

class DecorSuggestionEntity {
  final String category;
  final String text;

  DecorSuggestionEntity({
    required this.category,
    required this.text,
  });
}