import 'package:flutter/material.dart';
import '../../../abstraction/base_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Profile Page',
      icon: Icons.person,
      iconOutlined: Icons.person_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Profile page!", style: TextStyle(fontSize: 20)),
          SizedBox(height: 16),
          Text("You can modify your profile here.", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
