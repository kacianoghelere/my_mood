import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_mood/enums/mood_type.dart';
import 'package:my_mood/helpers/date_time_helper.dart';
import 'package:my_mood/model/mood_entry.dart';
import 'package:my_mood/providers/mood_provider.dart';
import 'package:my_mood/widgets/mood_form.dart';
import 'package:provider/provider.dart';

class MoodEntriesList extends StatelessWidget {
  const MoodEntriesList({super.key});

  Map<String, List<MoodEntry>> _groupEntriesByDay(List<MoodEntry> entries) {
    final Map<String, List<MoodEntry>> groupedEntries = {};

    for (var entry in entries) {
      final day = DateFormat('yyyy-MM-dd').format(entry.dateTime);

      if (!groupedEntries.containsKey(day)) {
        groupedEntries[day] = [];
      }

      groupedEntries[day]!.add(entry);
    }

    return groupedEntries;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodProvider>(
      builder: (context, moodProvider, child) {
        final moodEntries = moodProvider.moodEntries;

        if (moodEntries.isEmpty) {
          return const Center(child: Text('Nenhum registro de humor.'));
        }

        final groupedEntries = _groupEntriesByDay(moodEntries);

        return ListView(
          children: groupedEntries.keys.map((day) {
            final entriesForDay = groupedEntries[day]!;

            final isCurrentDay = DateTimeHelper.isSameDay(
              DateTime.now(),
              entriesForDay[0].dateTime
            );

            final titleText = DateFormat('dd/MM/yyyy').format(DateTime.parse(day));

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    titleText + (isCurrentDay ? ' (Hoje)' : ''),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Column(
                  children: entriesForDay.map((entry) {
                    final hasDetails = entry.details != null && entry.details!.isNotEmpty;

                    return ListTile(
                      leading: Icon(MoodType.getIconData(entry.moodLevel), size: 36),
                      title: Text(
                        DateFormat('dd/MM/yyyy HH:mm:ss').format(entry.dateTime),
                      ),
                      subtitle: hasDetails ? Text(entry.details!) : null,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => moodProvider.deleteMoodEntry(entry),
                      ),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (_) => MoodForm(moodEntry: entry),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}