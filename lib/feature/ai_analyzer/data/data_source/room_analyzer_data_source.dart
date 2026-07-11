import 'dart:convert';
import 'dart:io';
import 'package:decora/core/utils/constant/endpoints.dart';
import 'package:decora/core/utils/service/api_service.dart';
import 'package:decora/feature/ai_analyzer/data/models/room_analyzer_model.dart';

class AiSuggestionDataSource {
  final ApiService apiService;

  AiSuggestionDataSource({required this.apiService});

  Future<RoomAnalysisModel> getSuggestions(File roomImage) async {
    final imageBytes = await roomImage.readAsBytes();
    final base64Image = base64Encode(imageBytes);
final mimeType = roomImage.path.toLowerCase().endsWith('.png')
    ? 'image/png'
    : 'image/jpeg';
    final prompt = '''
You are a professional interior decorator. Analyze this room image and determine:

1. The dominant colors in the room (return them as hex codes, e.g., #D56E49)
2. The overall style that best fits (modern, classic, bohemian, minimal)
3. 3 decor suggestions, each linked to exactly one category from the categories available in the app:
 Wall Art, Mirrors, Shelves, Curtains, Paint

Return JSON only, with no additional text, in this exact format:
{
  "dominantColors": ["#D56E49", "#F5E6D3"],
  "style": "...",
  "suggestions": [{"category": "...", "text": "..."}]
}
''';

    final response = await apiService.post(
      EndPoints.generateContent,
      headers: {
        "Content-Type": "application/json",
        "x-goog-api-key": EndPoints.apiKey,
      },
      data: {
        'contents': [
          {
            'parts': [
              {'text': prompt},
              {
                'inline_data': {
                  'mime_type': mimeType,
                  'data': base64Image,
                }
              },
            ]
          }
        ],
      },
    );

    final text = response['candidates'][0]['content']['parts'][0]['text'] as String;
    final cleanJson = text.replaceAll('```json', '').replaceAll('```', '').trim();
    final jsonMap = jsonDecode(cleanJson);

    return RoomAnalysisModel.fromJson(jsonMap);
  }
}