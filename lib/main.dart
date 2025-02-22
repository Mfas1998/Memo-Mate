import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo_mate/app.dart';
import 'package:memo_mate/core/utils/simple_bloc_observer.dart';
import 'Features/notes/data/models/category_model.dart';
import 'Features/notes/data/models/note_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox<NoteModel>('notes');
  await Hive.openBox<CategoryModel>('categories');
  Bloc.observer = SimpleBlocObserver();
  runApp(const MemoMate());
}
