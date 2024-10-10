import 'package:flutter/material.dart';
import 'package:my_mood/model/mood_entry.dart';
import 'package:my_mood/screens/main_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';
import 'providers/mood_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [MoodEntrySchema],
    directory: dir.path,
  );

  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  final Isar isar;

  const MyApp({Key? key, required this.isar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoodProvider(isar)),
      ],
      child: MaterialApp(
        title: 'Mood Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo).copyWith(
            surfaceTint: Colors.transparent,
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            shadowColor: Theme.of(context).colorScheme.shadow,
          )
        ),
        home: const MainScreen(),
      ),
    );
  }
}