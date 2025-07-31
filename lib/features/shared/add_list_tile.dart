import 'package:flutter/material.dart';

class AddListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AddListTile({required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorScheme.outline, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: colorScheme.secondaryContainer,
      leading: Icon(Icons.add, color: colorScheme.outline),
      title: Text(title, style: TextStyle(color: colorScheme.outline)),
      onTap: onTap,
    );
  }
}
