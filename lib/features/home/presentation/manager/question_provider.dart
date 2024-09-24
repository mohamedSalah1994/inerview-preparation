import 'package:flutter/material.dart';
import 'package:interview_preparation/features/home/data/repos/question_repo_impl.dart';

class QuestionProvider with ChangeNotifier {
  final QuestionRepoImpl _questionRepoImpl = QuestionRepoImpl();

  List<Map<String, dynamic>> _questions = [];
  List<Map<String, dynamic>> get questions => _questions;

  Future<void> fetchQuestions() async {
    try {
      _questions = await _questionRepoImpl.getQuestions();
      if (_questions.isEmpty) {
        debugPrint('No questions found in SQLite.');
      } else {
        debugPrint('Questions loaded: $_questions');
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching questions: $e');
    }
  }
  void addQuestion(String question, String answer) async {
    // Insert question into the database
    await _questionRepoImpl.insertQuestion({
      'id': DateTime.now().toString(), // Unique ID
      'question': question,
      'answer': answer,
    });
  }

    Future<void> searchQuestions(String query) async {
    try {
      if (query.isEmpty) {
        await fetchQuestions();
      } else {
        _questions = await _questionRepoImpl.searchQuestions(query);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error searching questions: $e');
    }
  }
}
