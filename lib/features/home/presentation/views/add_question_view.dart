import 'package:flutter/material.dart';
import 'package:interview_preparation/features/home/presentation/views/widgets/add_question_view_body.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_app_drawer.dart';

class AddQuestionPage extends StatelessWidget {
 

  const AddQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      appBar: buildAppBar(context, title: 'Add Question'),
       drawer: const AppDrawer(),
      body: const AddQuestionViewBody()
    );
  }
}
