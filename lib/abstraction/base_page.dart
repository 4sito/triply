import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final String? title;
  final Widget child;
  final IconData? icon;
  final IconData? iconOutlined;
  final List<Widget>? actions;
  final FloatingActionButtonLocation? fabLocation;
  final FloatingActionButton? floatingActionButton;

  const BasePage({
    super.key,
    this.title,
    required this.child,
    required this.icon,
    required this.iconOutlined,
    this.actions,
    this.fabLocation,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(title), actions: actions),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: fabLocation,
    );
  }
}
