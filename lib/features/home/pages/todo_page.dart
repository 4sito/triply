import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../abstraction/base_page.dart';
import 'dart:developer';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = []; // ref.watch(tripListProvider);
    // print("trips: $trips, trips is empty? ${trips.isEmpty}");

    Widget pageBody;

    if (list.isEmpty) {
      pageBody = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.list_alt, size: 64, color: Colors.grey),
                onPressed: () =>
                    log("clicked add list"), // onAddTrip(context)},
              ),
              SizedBox(height: 16),
              Text('No lists added yet.', style: TextStyle(fontSize: 18)),
            ],
          ),
        ],
      );
    } else {
      pageBody = ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final finalList = list[index];
          return ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(finalList.name),
            subtitle: Text(
              '${finalList.destination} • ${finalList.startDate.toString().split(" ")[0]} → ${finalList.endDate.toString().split(" ")[0]}',
            ),
            onTap: () {
              log("clicked create list");
              //   Navigator.push(
              //     context,
              //     // MaterialPageRoute(
              //     //     ; //; log("clicked create list");//CreateTripPage(tripIndex: index),
              //     // ),
              //   );
            },
          );
        },
      );
    }
    return BasePage(
      title: 'Your Lists',
      icon: Icons.list_alt,
      iconOutlined: Icons.list_alt_outlined,
      child: pageBody,
    );
  }
}
