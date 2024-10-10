// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum MoodType {
  very_dissatisfied,
  dissatisfied,
  neutral,
  satisfied,
  very_satisfied;

  static MoodType parse(String mood) {
    return switch (mood) {
      'very_dissatisfied' => MoodType.very_dissatisfied,
      'dissatisfied' => MoodType.dissatisfied,
      'neutral' => MoodType.neutral,
      'satisfied' => MoodType.satisfied,
      'very_satisfied' => MoodType.very_satisfied,
      _ => throw ArgumentError('Invalid MoodType name')
    };
  }

  static MoodType fromValue(int moodValue) {
    return switch (moodValue) {
      1 => MoodType.very_dissatisfied,
      2 => MoodType.dissatisfied,
      3 => MoodType.neutral,
      4 => MoodType.satisfied,
      5 => MoodType.very_satisfied,
      _ => throw ArgumentError('Invalid MoodType value')
    };
  }

  static IconData getIconData(int moodValue) {
    return switch (moodValue) {
      1 => Icons.sentiment_very_dissatisfied,
      2 => Icons.sentiment_dissatisfied,
      3 => Icons.sentiment_neutral,
      4 => Icons.sentiment_satisfied,
      5 => Icons.sentiment_very_satisfied,
      _ => throw ArgumentError('Invalid MoodType value')
    };
  }

  static String getText(int moodValue) {
    return switch (moodValue) {
      1 => 'Muito insatisfeito',
      2 => 'Insatisfeito',
      3 => 'Neutro',
      4 => 'Satisfeito',
      5 => 'Muito satisfeito',
      _ => throw ArgumentError('Invalid MoodType value')
    };
  }
}

extension MoodTypeExtension on MoodType {
  String get name {
    return switch (this) {
      MoodType.very_dissatisfied => 'very_dissatisfied',
      MoodType.dissatisfied => 'dissatisfied',
      MoodType.neutral => 'neutral',
      MoodType.satisfied => 'satisfied',
      MoodType.very_satisfied => 'very_satisfied',
    };
  }
}