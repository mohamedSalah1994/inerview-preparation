import 'package:flutter/material.dart';
import 'package:interview_preparation/core/utils/app_colors.dart';
import 'package:interview_preparation/core/widgets/custom_app_bar.dart';

import 'package:interview_preparation/features/home/presentation/views/widgets/home_view_body.dart';


import '../../../../core/widgets/custom_app_drawer.dart';
import 'add_question_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context, title: 'Home'),
       drawer: const AppDrawer(),
      body: const HomeViewBody(),
      floatingActionButton: const CustomFloatingActionButton(),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddQuestionPage()),
        );
      },
      child: const Icon(Icons.add , color: Colors.white,),
    );
  }
}
