import 'package:cloud_firestore/cloud_firestore.dart';

// Abstract class for remote data source
abstract class HomeRemoteDataSource {
  Future<List<Map<String, dynamic>>> getRemoteQuestions();
  Future<void> addQuestionRemote(Map<String, dynamic> questionData);
}

// Firebase implementation for remote data source
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getRemoteQuestions() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('questions').get();

    // Converting the snapshot into a list of maps
    return querySnapshot.docs
        .map((doc) => {
              'id': doc.id,
              'question': doc['question'],
              'answer': doc['answer'],
            })
        .toList();
  }

  @override
  Future<void> addQuestionRemote(Map<String, dynamic> questionData) async {
    await _firestore.collection('questions').add({
      'question': questionData['question'],
      'answer': questionData['answer'],
    });
  }
}
