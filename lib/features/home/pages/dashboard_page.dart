import 'package:flutter/material.dart';
import '../../../abstraction/base_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Dashboard',
      icon: Icons.home,
      iconOutlined: Icons.home_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Welcome back!", style: TextStyle(fontSize: 20)),
          SizedBox(height: 16),
          Text("Your upcoming trips, stats, or highlights here."),
        ],
      ),
    );
  }
}
