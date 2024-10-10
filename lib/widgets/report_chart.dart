import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_mood/enums/mood_type.dart';
import 'package:my_mood/model/mood_entry.dart';

class ReportChart extends StatelessWidget {
  final List<MoodEntry> filteredEntries;

  const ReportChart({super.key, required this.filteredEntries});

  BarChartGroupData _buildBarChartGroup(int moodLevel, int frequency, Color color) {
    return BarChartGroupData(
      x: moodLevel,
      barRods: [
        BarChartRodData(
          toY: frequency.toDouble(),
          color: color,
          width: 20,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final moodCount = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (var entry in filteredEntries) {
      moodCount[entry.moodLevel] = (moodCount[entry.moodLevel] ?? 0) + 1;
    }

    final primaryThemeColor = Theme.of(context).primaryColor;

    return AspectRatio(
      aspectRatio: 1,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(drawVerticalLine: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Icon(
                      MoodType.getIconData(value.toInt()),
                      size: 32,
                      color: primaryThemeColor
                    ),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false, interval: 1, reservedSize: 32.0),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 1, reservedSize: 32.0),
            ),
            topTitles:  const AxisTitles(
              sideTitles: SideTitles(showTitles: false, interval: 1),
            ),
          ),
          barGroups: [1, 2, 3, 4, 5].map((moodValue) => (
            _buildBarChartGroup(moodValue, moodCount[moodValue]!, primaryThemeColor)
          )).toList(),
        ),
      ),
    );
  }
}