import 'package:hive/hive.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:memo_mate/Features/notes/data/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  void deleteNote({required NoteModel note}) {
    note.delete();
  }

  @override
  void editNote({required NoteModel note}) {
    note.save();
  }

  @override
  List<NoteModel> getNotes({String category = 'all notes'}) {
    var noteBox = Hive.box<NoteModel>('notes');

    if (category == 'all notes') {
      return noteBox.values.toList().reversed.toList();
    } else {
      return noteBox.values
          .toList()
          .reversed
          .toList()
          .where((element) => element.category == category)
          .toList();
    }
  }

  @override
  Future addNote({required NoteModel note}) async {
    var noteBox = Hive.box<NoteModel>('notes');
    await noteBox.add(note);
  }
}
