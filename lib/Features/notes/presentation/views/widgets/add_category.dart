import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo_mate/Features/notes/data/models/category_model.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/custom_text_form_field.dart';
import 'package:memo_mate/core/utils/constants.dart';
import '../../cubits/category_cubit/category_cubit.dart';
import 'color_picker_button.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    Color selectedColor = categoryColors[0];
    TextEditingController categoryName = TextEditingController();
    GlobalKey<FormState> formState = GlobalKey<FormState>();
    final categories = BlocProvider.of<CategoryCubit>(context)
        .getCategories()
        .map((e) => e.categoryName);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formState,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Add Category',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            StatefulBuilder(
              builder: (context, setState) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: categoryColors.map((e) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = e;
                      });
                    },
                    child: ColorPickerButton(
                      color: e,
                      selected: selectedColor == e,
                    ),
                  );
                }).toList(),
              ),
            ),
            CustomTextFormField(
              label: 'Name',
              controller: categoryName,
              autoFocus: true,
              validator: (value) {
                return value == ''
                    ? 'The field is required'
                    : categories.contains(value)
                        ? 'The category is already exist'
                        : null;
              },
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                // const SizedBox(width: 16),
                TextButton(
                    onPressed: () async {
                      if (formState.currentState!.validate()) {
                        CategoryModel category = CategoryModel(
                            categoryName: categoryName.text,
                            color: selectedColor.value);

                        BlocProvider.of<CategoryCubit>(context)
                            .addCategory(category: category);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
