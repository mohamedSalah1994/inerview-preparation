import 'package:flutter/material.dart';
import 'package:interview_preparation/features/home/presentation/views/home_view.dart';
import 'package:provider/provider.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../manager/question_provider.dart';

class AddQuestionViewBody extends StatefulWidget {
  const AddQuestionViewBody({super.key});

  @override
  State<AddQuestionViewBody> createState() => _AddQuestionViewBodyState();
}

class _AddQuestionViewBodyState extends State<AddQuestionViewBody> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: questionController,
            decoration: const InputDecoration(labelText: 'Question'),
          ),
          TextField(
            controller: answerController,
            decoration: const InputDecoration(labelText: 'Answer'),
          ),
          const SizedBox(height: 20),
          CustomButton(
              onPressed: () {
                String question = questionController.text;
                String answer = answerController.text;

                questionProvider.addQuestion(question, answer);

                Navigator.pushReplacementNamed(context, HomeView.routeName);
              },
              text: 'Add Question'),
        ],
      ),
    );
  }
}
