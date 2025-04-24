class Tutorial {
  final String id;
  final String title;
  final String description;
  final String subject;
  final String contentUrl;
  final String contentType; // 'text', 'video', 'audio'
  final int duration; // in minutes
  final int difficultyLevel; // 1-5
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Tutorial({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.contentUrl,
    required this.contentType,
    required this.duration,
    required this.difficultyLevel,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tutorial.fromJson(Map<String, dynamic> json) {
    return Tutorial(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      subject: json['subject'],
      contentUrl: json['contentUrl'],
      contentType: json['contentType'],
      duration: json['duration'],
      difficultyLevel: json['difficultyLevel'],
      tags: List<String>.from(json['tags']),
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
      'contentUrl': contentUrl,
      'contentType': contentType,
      'duration': duration,
      'difficultyLevel': difficultyLevel,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
