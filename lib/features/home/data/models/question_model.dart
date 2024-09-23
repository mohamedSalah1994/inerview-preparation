class QuestionModel {
  final String id;
  final String question;
  final String answer;
  final DateTime timestamp; // To store the time when the question was added

  QuestionModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.timestamp,
  });

  // Convert a QuestionModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'timestamp': timestamp.toIso8601String(), // Store timestamp as a string
    };
  }

  // Create a QuestionModel from a Map
  factory QuestionModel.fromMap(String id, Map<String, dynamic> map) {
    return QuestionModel(
      id: id,
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }
}
