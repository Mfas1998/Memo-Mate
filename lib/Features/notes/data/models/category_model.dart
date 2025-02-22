import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String categoryName;
  @HiveField(1)
  int color;
  CategoryModel({required this.categoryName, required this.color});
}
