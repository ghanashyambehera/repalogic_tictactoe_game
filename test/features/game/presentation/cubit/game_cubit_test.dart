import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tictactoegame/core/utils/enums.dart';
import 'package:tictactoegame/features/game/domain/entities/game_state_entity.dart';
import 'package:tictactoegame/features/game/domain/usecases/load_game.dart';
import 'package:tictactoegame/features/game/domain/usecases/reset_game.dart';
import 'package:tictactoegame/features/game/domain/usecases/save_game.dart';
import 'package:tictactoegame/features/game/presentation/cubit/game_cubit.dart';

import '../../mocks/mock_game_repository.dart';

void main() {
  late MockGameRepository repository;
  late GameCubit cubit;

  setUp(() {
    repository = MockGameRepository();
    when(() => repository.loadGame()).thenAnswer((_) async => null);
    cubit = GameCubit(
      loadGame: LoadGame(repository),
      saveGame: SaveGame(repository),
      resetGame: ResetGame(repository),
    );
  });

  tearDown(() {
    cubit.close();
  });

  test("Initial state should be GameState.initial()", () {
    expect(cubit.state, GameState.initial());
  });

  blocTest<GameCubit, GameState>("init() should load saved game if exists",
    build: () {
      when(() => repository.loadGame()).thenAnswer(
        (_) async => GameStateEntity(
          board: ["X", "", "", "", "", "", "", "", ""],
          currentPlayer: "O",
          winner: "",
          mode: GameMode.vsPlayer,
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.init(),
    expect: () => [
      isA<GameState>().having((s) => s.isLoading, 'loading', true),
      isA<GameState>().having((s) => s.game.currentPlayer, 'player', 'O')
          .having((s) => s.game.board[0], 'cell 0', 'X'),
    ],
  );
}
