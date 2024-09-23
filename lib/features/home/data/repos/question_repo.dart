abstract class QuestionRepo {
  Future<List<Map<String, dynamic>>> getQuestions();
  Future<void> insertQuestion(Map<String, dynamic> question);
  Future<void> clearQuestions();
  
}