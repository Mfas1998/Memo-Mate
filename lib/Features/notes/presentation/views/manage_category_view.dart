import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/edit_category.dart';
import '../cubits/category_cubit/category_cubit.dart';
import 'widgets/confirm_dialog.dart';

class ManageCategoryView extends StatelessWidget {
  const ManageCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final categories =
            BlocProvider.of<CategoryCubit>(context).getCategories();
        return Scaffold(
          appBar: AppBar(
            title: const Text('manage categories'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: EditCategory(
                                    category: categories[index],
                                  ),
                                ));
                      },
                      title: Text(categories[index].categoryName),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ConfirmDialog(
                                    content: 'Delete this category?',
                                    cancelButtonText: 'Cancel',
                                    okButtonText: 'Delete',
                                    cancelFunction: () {
                                      Navigator.pop(context);
                                    },
                                    okFunction: () {
                                      BlocProvider.of<CategoryCubit>(context)
                                          .deleteCategory(
                                              category: categories[index]);
                                      Navigator.pop(context);
                                    }));
                          },
                          icon: const Icon(Iconsax.trash4)),
                      leading: Container(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.bottomLeft,
                        height: 20,
                        width: 25,
                        decoration: BoxDecoration(
                          color:
                              Color(categories[index].color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Container(
                          width: 7,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Color(categories[index].color),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(3),
                                bottomLeft: Radius.circular(3)),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
