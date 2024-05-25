import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiApiService {
  final GenerativeModel model;

  GeminiApiService(String apiKey)
      : model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey
  );

  Future<String> generateCustomRoadmap({
    required String direction,
    required int hoursPerDay,
    required int months,
    required String learningMethod,
    required int weekNumber
  }) async {
    final prompt = _buildPrompt(direction, hoursPerDay, months, learningMethod, weekNumber);
    final content = [Content.text(prompt)];
    print(prompt);
    try {
      final response = await model.generateContent(content);
      return response.text!;
    } catch (e) {
      print('Error generating content: $e');
      throw Exception('Failed to generate content');
    }
  }

  String _buildPrompt(String direction, int hoursPerDay, int months, String learningMethod, int weekNumber) {
    return """
I want to create a personalized learning roadmap in $direction for a $weekNumber-st week. Here are my details:

1. **Daily Commitment**: I can spend $hoursPerDay hours per day on my learning.
2. **Time Frame**: I want to become a professional in this field within $months months.
3. **Learning Method**: I prefer to learn by $learningMethod.

Based on this information, please create a step-by-step roadmap for me to follow. The roadmap should include:
- Daily tasks and milestones to keep me on track.
- Recommendations for resources (e.g., specific courses, books, games, or projects) that align with my preferred learning method.
- Weekly and monthly progress checks to ensure I'm on the right path.
- Any additional tips or advice to help me stay motivated and efficient in my learning journey.

Please structure the roadmap in a clear and short breakpoints , by dividing a week by 2-3 days, tailored to my learning preferences and time availability. Make the response as short and concise as possible, focusing on the key steps
    """;
  }
}
