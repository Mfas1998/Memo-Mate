import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo_mate/Features/notes/data/models/category_model.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  List<CategoryModel> getCategories() {
    var categoryBox = Hive.box<CategoryModel>('categories');
    return categoryBox.values.toList();
  }

  void addCategory({required CategoryModel category}) async {
    emit(CategoryLoading());
    var categoryBox = Hive.box<CategoryModel>('categories');
    categoryBox.add(category);
    emit(CategorySuccess());
  }

  void deleteCategory({required CategoryModel category}) async {
    await category.delete();
    emit(CategorySuccess());
  }

  void updateCategory({required CategoryModel category}) async {
    category.save();
    emit(CategorySuccess());
  }
}
