import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo_mate/Features/notes/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:memo_mate/Features/notes/presentation/views/home_view.dart';

import 'Features/notes/data/repos/home_repo_impl.dart';
import 'Features/notes/presentation/cubits/note_cubit/note_cubit.dart';

class MemoMate extends StatelessWidget {
  const MemoMate({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteCubit(HomeRepoImpl()),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(brightness: Brightness.dark),
        theme: ThemeData(brightness: Brightness.light),
        debugShowCheckedModeBanner: false,
        home: const HomeView(),
      ),
    );
  }
}
