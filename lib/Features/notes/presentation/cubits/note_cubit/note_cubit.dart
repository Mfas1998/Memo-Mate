import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:memo_mate/Features/notes/data/repos/home_repo.dart';
import 'package:meta/meta.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final HomeRepo homeRepp;

  NoteCubit(this.homeRepp) : super(NoteInitial());

  List<NoteModel> notes = [];

  void addNote(NoteModel note) async {
    emit(NoteLoading());
    try {
      await homeRepp.addNote(note: note);
      emit(NoteSuccess());
    } catch (e) {
      emit(NoteFailure());
    }
  }

  List<NoteModel> getNotes({String category = 'all notes'}) {
    return homeRepp.getNotes(category: category);
  }

  editNote(NoteModel note) async {
    homeRepp.editNote(note: note);
    emit(NoteSuccess());
  }

  deleteNote(NoteModel note) async {
    homeRepp.deleteNote(note: note);
    emit(NoteSuccess());
  }

  markFavorite(NoteModel note) {
    note.favorite = !note.favorite;
    note.save();
    emit(NoteSuccess());
  }
}
