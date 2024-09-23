import 'package:flutter/material.dart';

import 'package:interview_preparation/features/home/data/data_sources/home_local_data_source.dart';
import 'package:interview_preparation/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:interview_preparation/features/home/data/repos/question_repo.dart';

class QuestionRepoImpl implements QuestionRepo {
  final HomeLocalDataSource _localDataSource = HomeLocalDataSourceImpl();
  final HomeRemoteDataSource _remoteDataSource = HomeRemoteDataSourceImpl();

  @override
   Future<List<Map<String, dynamic>>> getQuestions() async {
    try {
      
      final remoteQuestions = await _remoteDataSource.getRemoteQuestions();
      debugPrint('Questions fetched from remote source: $remoteQuestions');

    
      return remoteQuestions;
    } catch (e) {
   
      debugPrint('Failed to fetch remote questions, trying local. Error: $e');
      final localQuestions = await _localDataSource.getQuestions();
      return localQuestions;
    } finally {
      // Cache remote questions to local SQLite for future offline use
      final remoteQuestions = await _remoteDataSource.getRemoteQuestions();
      if (remoteQuestions.isNotEmpty) {
        // Clear the old questions before inserting new ones
        await _localDataSource.clearQuestions();
        for (var question in remoteQuestions) {
          await _localDataSource.insertQuestion(question);
        }
        debugPrint('Remote questions cached locally');
      }
    }
  }

  @override
  Future<void> insertQuestion(Map<String, dynamic> questionData) async {
    // Insert question into the remote source (Firebase)
    await _remoteDataSource.addQuestionRemote(questionData);
    debugPrint('Question added to remote source: $questionData');

    // Save the same question to the local database
    await _localDataSource.insertQuestion(questionData);
    debugPrint('Question saved to local SQLite: $questionData');
  }

  @override
  Future<void> clearQuestions() async {
    // Clear questions locally (from SQLite)
    await _localDataSource.clearQuestions();
    debugPrint('Questions cleared from local SQLite');
  }
}
