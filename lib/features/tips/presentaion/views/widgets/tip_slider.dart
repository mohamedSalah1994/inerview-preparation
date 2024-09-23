import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../manager/tip_provider.dart';
import '../pro_view.dart'; // Import the ProView

class TipSlider extends StatelessWidget {
  const TipSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final tipProvider = Provider.of<TipProvider>(context);

    return tipProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : tipProvider.errorMessage != null
            ? Center(child: Text(tipProvider.errorMessage!))
            : tipProvider.tips.isEmpty
                ? const Center(child: Text("No tips available"))
                : PageView.builder(
                    itemCount: tipProvider.tips.length,
                    itemBuilder: (context, index) {
                      final tip = tipProvider.tips[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProView(itemName: tip['tip']),
                            ),
                          );
                        },
                        child: Hero(
                          tag: tip['tip'], // Use the tip text as the hero tag
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    tip['tip'] ?? 'No tip available',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
  }
}
