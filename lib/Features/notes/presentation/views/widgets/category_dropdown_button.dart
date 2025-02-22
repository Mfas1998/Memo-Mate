import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo_mate/Features/notes/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:memo_mate/Features/notes/presentation/views/manage_category_view.dart';

import 'add_category.dart';

class CategoryDropdownButton extends StatelessWidget {
  const CategoryDropdownButton({
    super.key,
    required this.onChange,
    this.selectedValue,
    this.allNotes = false,
  });
  final Function(Object?) onChange;
  final String? selectedValue;
  final bool allNotes;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final categories =
            BlocProvider.of<CategoryCubit>(context).getCategories();
        final hasCategories = categories.isNotEmpty;

        return DropdownButton(
            alignment: AlignmentDirectional.center,
            // isExpanded: true,
            value: selectedValue,
            // borderRadius: BorderRadius.circular(12),
            // padding: const EdgeInsets.symmetric(horizontal: 12),
            hint: const Text('Select Category'),
            underline: const SizedBox(),
            items: [
              if (allNotes)
                DropdownMenuItem(
                  // alignment: Alignment.center,
                  value: 'all notes',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: selectedValue == 'all notes'
                          ? Colors.blue.withOpacity(0.3)
                          : null,
                    ),
                    child: const Center(
                      child: Text('All Notes'),
                    ),
                  ),
                ),
              DropdownMenuItem(
                // alignment: Alignment.center,
                value: 'No Category',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: selectedValue == 'No Category'
                        ? Colors.blue.withOpacity(0.3)
                        : null,
                  ),
                  child: const Center(
                    child: Text('No Category'),
                  ),
                ),
              ),
              if (hasCategories)
                ...categories.map(
                  (e) => DropdownMenuItem(
                    // alignment: Alignment.center,
                    value: e.categoryName,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: selectedValue == e.categoryName
                            ? Colors.blue.withOpacity(0.3)
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.bottomLeft,
                            height: 20,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Color(e.color).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Container(
                              width: 7,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color(e.color),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    bottomLeft: Radius.circular(3)),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(e.categoryName),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              DropdownMenuItem(
                  onTap: () {},
                  value: 'create',
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => const Dialog(
                                    child: AddCategory(),
                                  ));
                        },
                        child: const Text(
                          'new',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ManageCategoryView()));
                        },
                        child: const Text(
                          'manage',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  )),
            ],
            selectedItemBuilder: (BuildContext context) {
              return [
                if (allNotes) const Center(child: Text('All Notes')),
                const Center(child: Text('No Category')),
                if (hasCategories)
                  ...categories.map((e) => Center(child: Text(e.categoryName)))
              ];
            },
            onChanged: (value) {
              if (value != 'create') {
                onChange(value);
              }
            });
      },
    );
  }
}
