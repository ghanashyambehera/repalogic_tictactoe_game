import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'core/utils/app_strings.dart';
import 'features/game/presentation/cubit/game_cubit.dart';
import 'features/game/presentation/pages/game_page.dart';

void main() {
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<GameCubit>()),
      ],
      child: MaterialApp(
        title: AppStrings.ticTacToe,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true
        ),
        home: const GamePage(),
      ),
    );
  }
}


