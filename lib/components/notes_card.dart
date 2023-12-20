import 'package:flutter/material.dart';
import 'package:winhealth_admin/models/notes.dart';

class NotesCard extends StatelessWidget {
  final Note note;
  const NotesCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.alarm),
          SizedBox(
            width: 8,
          ),
          Text(
            "${note.dateTime} -> ",
          ),
          Text(
            "${note.title}",
          )
        ],
      ),
    );
  }
}
