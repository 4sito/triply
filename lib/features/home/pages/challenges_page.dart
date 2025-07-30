import 'package:flutter/material.dart';
import 'base_page.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Challenges Page',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Challenges page!", style: TextStyle(fontSize: 20)),
          SizedBox(height: 16),
          Text("You can create, edit and complete challenges here.", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
