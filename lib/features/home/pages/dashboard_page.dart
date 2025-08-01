// dashboard_page.dart
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triply/features/challenges/controllers/challenge_controller.dart';
import 'package:triply/features/todo/controllers/todo_controller.dart';
import 'package:triply/features/trips/controllers/trip_controller.dart';

class DashboardPage extends ConsumerWidget {
  final void Function(int)? onSectionTap;

  const DashboardPage({super.key, this.onSectionTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripListProvider);
    final todos = ref.watch(todoListProvider);
    final challenges = ref.watch(challengeListProvider);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionCard(
          context,
          title: "Your Trips",
          count: trips.length,
          color: theme.colorScheme.primaryContainer,
          icon: Icons.airplane_ticket,
          onTap: () => onSectionTap?.call(1),
        ),
        _buildSectionCard(
          context,
          title: "Your Challenges",
          count: challenges.length,
          color: theme.colorScheme.tertiaryContainer,
          icon: Icons.extension,
          onTap: () => onSectionTap?.call(2),
        ),
        _buildSectionCard(
          context,
          title: "Your Todos",
          count: todos.length,
          color: theme.colorScheme.secondaryContainer,
          icon: Icons.check_circle_outline,
          onTap: () => onSectionTap?.call(3),
        ),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required int count,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Icon(icon, size: 32),
        title: Text(title, style: theme.textTheme.titleMedium),
        subtitle: Text("$count items"),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
