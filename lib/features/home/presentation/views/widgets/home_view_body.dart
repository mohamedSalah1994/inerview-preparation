import 'package:flutter/material.dart';
import 'package:interview_preparation/features/home/presentation/views/widgets/question_item.dart';
import 'package:provider/provider.dart';
import '../../../details_view.dart';
import '../../manager/question_provider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    bool isLargeScreen = screenSize.width > 600;

    // Using the QuestionProvider to fetch questions
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: questionProvider.fetchQuestions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading spinner while the questions are being fetched
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Display an error message if there was an issue loading the data
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 50, color: Colors.red),
                    const SizedBox(height: 10),
                    Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Retry fetching questions
                        questionProvider.fetchQuestions();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // Check if no questions are available
            if (questionProvider.questions.isEmpty) {
              return const Center(
                child: Text(
                  'No Questions Available',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }

            // Displaying the questions if data is available
            return ListView.builder(
              itemCount: questionProvider.questions.length,
              itemBuilder: (context, index) {
                final questionData = questionProvider.questions[index];
                String question = questionData['question'] ?? 'No question';
                String answer = questionData['answer'] ?? 'No answer';

                return QuestionItem(
                  question: question,
                  answer: answer,
                  isLargeScreen: isLargeScreen,
                  heroTag: 'question_$index',
                  onTap: () {
                    // Navigate to the DetailsView screen
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            DetailsView(
                          question: question,
                          answer: answer,
                          heroTag: 'question_$index',
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
