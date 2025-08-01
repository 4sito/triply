// lib/features/shared/entity_list_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:triply/features/shared/add_list_tile.dart';
import '../../../abstraction/base_page.dart';

typedef CreatePageBuilder = Widget Function();
typedef ItemTileBuilder<T> = Widget Function(
    BuildContext context, WidgetRef ref, T item, int index);

class EntityListPage<T> extends ConsumerWidget {
  /// Riverpod provider that exposes List
  final StateNotifierProvider<StateNotifier<List<T>>, List<T>> listProvider;

  /// Build a new/create page widget
  final CreatePageBuilder createPage;

  /// Build each tile for an item
  final ItemTileBuilder<T> itemTileBuilder;

  /// Empty‐state message & add-button title
  final String emptyMessage, addButtonTitle;

  /// BasePage title & icons
  final String pageTitle;
  final IconData icon, iconOutlined;

  const EntityListPage({
    super.key,
    required this.listProvider,
    required this.createPage,
    required this.itemTileBuilder,
    required this.emptyMessage,
    required this.addButtonTitle,
    required this.pageTitle,
    required this.icon,
    required this.iconOutlined,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(listProvider);
    final theme = Theme.of(context);

    Widget pageBody;
    if (items.isEmpty) {
      pageBody = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emptyMessage, style: theme.textTheme.titleMedium),
          const SizedBox(height: 16),
          AddListTile(
            title: addButtonTitle,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => createPage()),
            ),
          ),
        ],
      );
    } else {
      pageBody = ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (ctx, i) {
          if (i == items.length) {
            return AddListTile(
              title: addButtonTitle,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => createPage()),
              ),
            );
          }
          return itemTileBuilder(ctx, ref, items[i], i);
        },
      );
    }

    return BasePage(
      title: pageTitle,
      icon: icon,
      iconOutlined: iconOutlined,
      child: pageBody,
    );
  }
}
