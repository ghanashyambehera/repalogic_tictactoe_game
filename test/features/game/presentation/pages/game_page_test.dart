import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoegame/core/di/injection.dart';
import 'package:tictactoegame/features/game/presentation/cubit/game_cubit.dart';
import 'package:tictactoegame/features/game/presentation/pages/game_page.dart';

void main(){

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    initDependencies();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => sl<GameCubit>(),
        child: const GamePage(),
      ),
    );
  }

  testWidgets("Game should render basic ui ", (tester)  async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text("Tic Tac Toe"), findsOneWidget);
    expect(find.textContaining("Turn:"), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byKey(const Key("reset_btn")), findsOneWidget);

  });


  testWidgets("Tap on first cell should place X", (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("cell_0")));
    await tester.pumpAndSettle();
    expect(find.text("X"), findsOneWidget);
  });

  testWidgets("After X move, turn should change to O (vsPlayer)", (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();
    expect(find.text("Turn: X"), findsOneWidget);
    await tester.tap(find.byKey(const Key("cell_0")));
    await tester.pumpAndSettle();
    expect(find.text("Turn: O"), findsOneWidget);
  });


}