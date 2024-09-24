import 'package:flutter/material.dart';
import 'package:interview_preparation/features/home/presentation/views/widgets/question_item.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../details_view.dart';
import '../../manager/question_provider.dart';


class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewBodyState createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.fetchQuestions();
  }

  // Trigger search based on text input
  Future<void> _onSearchChanged(String query) async {
    setState(() {
      _isSearching = true;
    });

    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    await questionProvider.searchQuestions(query);

    setState(() {
      _isSearching = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    final Size screenSize = MediaQuery.of(context).size;
    bool isLargeScreen = screenSize.width > 600;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            searchBar(),
            Expanded(
              child: _isSearching
                  ? const Center(child: CircularProgressIndicator())
                  : questionProvider.questions.isEmpty
                      ? const Center(
                          child: Text(
                            'No Questions Available',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        )
                      : ListView.builder(
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
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) =>
                                        DetailsView(
                                      question: question,
                                      answer: answer,
                                      heroTag: 'question_$index',
                                    ),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
                        ),
            ),
          ],
        ),
      ),
    );
  }

  TextField searchBar() {
    return TextField(
            controller: _searchController,
            onChanged: (query) {
              _onSearchChanged(query);
            },
            decoration: InputDecoration(
              hintText: 'Search questions...',
              prefixIcon: const Icon(Icons.search , color: AppColors.lightPrimaryColor,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.lightPrimaryColor), // Set the border color
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.lightPrimaryColor), // Set the enabled border color
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.lightPrimaryColor), // Set the focused border color
              ),
            ),
          );
  }
}
