import 'package:flutter/material.dart';
import 'package:interview_preparation/core/widgets/custom_app_bar.dart';
import 'package:interview_preparation/core/widgets/custom_app_drawer.dart';
import 'package:interview_preparation/features/tips/presentaion/views/widgets/tip_slider.dart';
import 'package:provider/provider.dart';

import '../manager/tip_provider.dart';

class TipView extends StatefulWidget {
  const TipView({Key? key}) : super(key: key);
  static const routeName = '/tips';
  @override
  // ignore: library_private_types_in_public_api
  _TipViewState createState() => _TipViewState();
}

class _TipViewState extends State<TipView> {
  @override
  void initState() {
    super.initState();
    // Fetch tips when the view is initialized
    Provider.of<TipProvider>(context, listen: false).fetchTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'tips'),
      drawer: const AppDrawer(),
      body: const TipSlider(), // Display the TipSlider
    );
  }
}
