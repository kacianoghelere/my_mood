import 'package:flutter/material.dart';
import 'package:my_mood/enums/mood_type.dart';
import 'package:my_mood/model/mood_entry.dart';
import 'package:my_mood/providers/mood_provider.dart';
import 'package:my_mood/widgets/report_chart.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _selectedDays = 7;

  List<MoodEntry> _getEntriesForPeriod(List<MoodEntry> entries) {
    final DateTime now = DateTime.now();

    final DateTime startDate = now.subtract(Duration(days: _selectedDays));

    return entries.where((entry) => entry.dateTime.isAfter(startDate)).toList();
  }

  IconData _getPredominantMoodIcon(List<MoodEntry> filteredEntries) {
    if (filteredEntries.isEmpty) return Icons.sentiment_neutral;

    final moodCount = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (var entry in filteredEntries) {
      moodCount[entry.moodLevel] = (moodCount[entry.moodLevel] ?? 0) + 1;
    }

    final predominantMood = moodCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    return MoodType.getIconData(predominantMood);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Relatório de Humor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Selector para o período
            DropdownButton<int>(
              value: _selectedDays,
              items: const [
                DropdownMenuItem(value: 7, child: Text('Últimos 7 dias')),
                DropdownMenuItem(value: 15, child: Text('Últimos 15 dias')),
                DropdownMenuItem(value: 30, child: Text('Últimos 30 dias')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedDays = value ?? 7;
                });
              },
            ),
            const SizedBox(height: 32),
            Consumer<MoodProvider>(
              builder: (context, moodProvider, child) {
                final filteredEntries = _getEntriesForPeriod(moodProvider.moodEntries);

                final predominantMoodIcon = _getPredominantMoodIcon(filteredEntries);

                final moodCount = <int, int>{
                  1: 0,
                  2: 0,
                  3: 0,
                  4: 0,
                  5: 0
                };

                for (var entry in filteredEntries) {
                  moodCount[entry.moodLevel] = (moodCount[entry.moodLevel] ?? 0) + 1;
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 64.0),
                      child: Column(
                        children: [
                          Icon(
                            predominantMoodIcon,
                            size: 100,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Humor predominante no período selecionado',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ),
                    ReportChart(filteredEntries: filteredEntries)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
