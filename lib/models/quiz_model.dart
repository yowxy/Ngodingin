import 'dart:convert';

class QuizQuestion {
  final String id;
  final String lessonId;
  final String question;
  final List<String> choices;

  QuizQuestion({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.choices,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    // choices may come as a JSON-encoded string from API
    final rawChoices = json['choices'];
    List<String> parsedChoices;
    if (rawChoices is String) {
      try {
        final decoded = (rawChoices.isNotEmpty) ? (jsonDecode(rawChoices) as List) : <dynamic>[];
        parsedChoices = decoded.map((e) => e.toString()).toList();
      } catch (_) {
        parsedChoices = <String>[];
      }
    } else if (rawChoices is List) {
      parsedChoices = rawChoices.map((e) => e.toString()).toList();
    } else {
      parsedChoices = <String>[];
    }

    return QuizQuestion(
      id: json['id'].toString(),
      lessonId: json['lesson_id'].toString(),
      question: json['question']?.toString() ?? '',
      choices: parsedChoices,
    );
  }
}

class CompleteQuizResult {
  final bool success;
  final String message;
  final int score;
  final int maxScore;
  final Map<String, dynamic>? nextLesson; // optional minimal structure

  CompleteQuizResult({
    required this.success,
    required this.message,
    required this.score,
    required this.maxScore,
    this.nextLesson,
  });

  factory CompleteQuizResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    return CompleteQuizResult(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      score: (data?['score'] ?? 0) is int ? data!['score'] as int : int.tryParse(data?['score']?.toString() ?? '0') ?? 0,
      maxScore: (data?['max_score'] ?? 0) is int ? data!['max_score'] as int : int.tryParse(data?['max_score']?.toString() ?? '0') ?? 0,
      nextLesson: data?['next_lesson'] as Map<String, dynamic>?,
    );
  }
}
