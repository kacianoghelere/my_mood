import 'package:flutter/material.dart';
import 'package:my_mood/widgets/mood_entries_list.dart';
import 'package:my_mood/widgets/mood_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Monitor de Humor'),
      ),
      body: const MoodEntriesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const MoodForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}