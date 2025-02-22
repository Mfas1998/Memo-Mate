import 'package:memo_mate/Features/notes/data/models/note_model.dart';

abstract class HomeRepo {
  List<NoteModel> getNotes({String category = 'all category'});
  Future addNote({required NoteModel note});
  void deleteNote({required NoteModel note});
  void editNote({required NoteModel note});
}
