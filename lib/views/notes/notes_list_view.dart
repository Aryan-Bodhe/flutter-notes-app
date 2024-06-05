import 'package:flutter/material.dart';
import 'package:mynotes/services/crud/notes_service.dart';
import 'package:mynotes/utilities/dialogs/delete_dialog.dart';

typedef DeleteNoteCallBack = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  const NotesListView({
    super.key,
    required this.notes,
    required this.onDeleteNote,
  });

  final List<DatabaseNote> notes;
  final DeleteNoteCallBack onDeleteNote;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(
            note.text,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          shape: const ContinuousRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 0.5,
            ),
          ),
          tileColor: Colors.amber.shade200,
          trailing: IconButton(
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);
              if(shouldDelete) {
                onDeleteNote(note);
              }
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
