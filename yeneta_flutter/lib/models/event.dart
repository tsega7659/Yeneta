class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String category;
  final List<String> attendees;
  final int maxAttendees;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.category,
    required this.attendees,
    required this.maxAttendees,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      category: json['category'],
      attendees: List<String>.from(json['attendees']),
      maxAttendees: json['maxAttendees'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'category': category,
      'attendees': attendees,
      'maxAttendees': maxAttendees,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
