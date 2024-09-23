import 'package:flutter/material.dart';
import 'package:interview_preparation/core/widgets/custom_app_bar.dart';

import '../../../../core/widgets/custom_app_drawer.dart';

class DetailsView extends StatelessWidget {
  final String question;
  final String answer;
  final String heroTag;

  const DetailsView({
    Key? key,
    required this.question,
    required this.answer,
    required this.heroTag,
  }) : super(key: key);
static const String routeName = '/details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Details'),
       drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: heroTag,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Answer:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              answer,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
