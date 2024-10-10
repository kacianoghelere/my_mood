import 'package:flutter/material.dart';
import 'package:my_mood/enums/mood_type.dart';
import 'package:my_mood/model/mood_entry.dart';
import 'package:my_mood/providers/mood_provider.dart';
import 'package:provider/provider.dart';

class MoodForm extends StatefulWidget {
  final MoodEntry? moodEntry;

  const MoodForm({super.key, this.moodEntry});

  @override
  State<MoodForm> createState() => _MoodFormState();
}

class _MoodFormState extends State<MoodForm> {
  int _moodLevel = 3;
  final TextEditingController _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.moodEntry != null) {
      _moodLevel = widget.moodEntry!.moodLevel;
      _detailsController.text = widget.moodEntry!.details ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar Humor'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              MoodType.getIconData(_moodLevel),
              color: Theme.of(context).primaryColor,
              size: 50
            ),
            Slider(
              min: 1,
              max: 5,
              divisions: 4,
              value: _moodLevel.toDouble(),
              onChanged: (value) {
                setState(() {
                  _moodLevel = value.toInt();
                });
              },
            ),
            TextField(
              controller: _detailsController,
              decoration: const InputDecoration(labelText: 'Como você se sente? (Opcional)'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            final moodProvider = Provider.of<MoodProvider>(context, listen: false);
            if (widget.moodEntry == null) {
              final newMood = MoodEntry(moodLevel: _moodLevel, details: _detailsController.text);
              moodProvider.addMoodEntry(newMood);
            } else {
              final updatedMood = widget.moodEntry!;
              updatedMood.moodLevel = _moodLevel;
              updatedMood.details = _detailsController.text;
              moodProvider.updateMoodEntry(updatedMood);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
