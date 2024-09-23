import 'package:flutter/material.dart';
import 'package:interview_preparation/core/helper_functions/database_helper.dart';

// Abstract class for local data source
abstract class HomeLocalDataSource {
  Future<List<Map<String, dynamic>>> getQuestions();
  Future<void> insertQuestion(Map<String, dynamic> questionData);
  Future<void> clearQuestions();
}

// Implementation class for local SQLite operations
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Future<List<Map<String, dynamic>>> getQuestions() async {
    final db = await _dbHelper.database;
    final questions = await db.query('questions');
    debugPrint('Questions fetched from SQLite: $questions');
    return questions;
  }

  @override
  Future<void> insertQuestion(Map<String, dynamic> questionData) async {
    final db = await _dbHelper.database;
    await db.insert('questions', questionData);
    debugPrint('Question inserted into SQLite: $questionData');
  }

  @override
  Future<void> clearQuestions() async {
    final db = await _dbHelper.database;
    await db.delete('questions');
    debugPrint('All questions cleared from SQLite');
  }
}
