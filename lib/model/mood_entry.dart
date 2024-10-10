import 'package:isar/isar.dart';

part 'mood_entry.g.dart';

@collection
class MoodEntry {
  Id id = Isar.autoIncrement;

  late DateTime dateTime;

  late int moodLevel; // 1 a 5

  String? details;

  MoodEntry({required this.moodLevel, this.details}) {
    dateTime = DateTime.now();
  }
}
