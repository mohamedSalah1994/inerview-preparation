import 'package:flutter/material.dart';
import 'package:interview_preparation/core/helper_functions/database_helper.dart';

// Abstract class for local data source
abstract class TipLocalDataSource {
  Future<List<Map<String, dynamic>>> getTips();

}

// Implementation class for local SQLite operations
class TipLocalDataSourceImpl implements TipLocalDataSource {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Future<List<Map<String, dynamic>>> getTips() async {
    final db = await _dbHelper.database;
    final tips = await db.query('tips');
    debugPrint('Tips fetched from SQLite: $tips');
    return tips;
  }


}
