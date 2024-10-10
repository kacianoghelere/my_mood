import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:my_mood/model/mood_entry.dart';

class MoodProvider with ChangeNotifier {
  final Isar isar;
  List<MoodEntry> _moodEntries = [];

  MoodProvider(this.isar) {
    _loadMoodEntries();
  }

  List<MoodEntry> get moodEntries => _moodEntries;

  Future<void> _loadMoodEntries() async {
    _moodEntries = await isar.moodEntrys.where().sortByDateTimeDesc().findAll();

    notifyListeners();
  }

  Future<void> addMoodEntry(MoodEntry moodEntry) async {
    await isar.writeTxn(() async {
      await isar.moodEntrys.put(moodEntry);
    });

    _loadMoodEntries();
  }

  Future<void> deleteMoodEntry(MoodEntry moodEntry) async {
    await isar.writeTxn(() async {
      await isar.moodEntrys.delete(moodEntry.id);
    });

    _loadMoodEntries();
  }

  Future<void> updateMoodEntry(MoodEntry moodEntry) async {
    await isar.writeTxn(() async {
      await isar.moodEntrys.put(moodEntry);
    });

    _loadMoodEntries();
  }
}
