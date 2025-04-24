class Quiz {
  final String id;
  final String title;
  final String description;
  final String subject;
  final List<Question> questions;
  final int timeLimit; // in minutes
  final int passingScore;
  final DateTime createdAt;
  final DateTime updatedAt;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.questions,
    required this.timeLimit,
    required this.passingScore,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      subject: json['subject'],
      questions:
          (json['questions'] as List).map((q) => Question.fromJson(q)).toList(),
      timeLimit: json['timeLimit'],
      passingScore: json['passingScore'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'subject': subject,
      'questions': questions.map((q) => q.toJson()).toList(),
      'timeLimit': timeLimit,
      'passingScore': passingScore,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String? explanation;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['_id'],
      text: json['text'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correctOptionIndex'],
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'text': text,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
      'explanation': explanation,
    };
  }
}
