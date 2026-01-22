


part of 'game_cubit.dart';


class GameState extends Equatable {
  final GameStateEntity game;
  final bool isLoading;

  const GameState({
    required this.game,
    required this.isLoading,
  });

  factory GameState.initial() {
    return GameState(
      isLoading: false,
      game: GameStateEntity(
        board: List.filled(9, ""),
        currentPlayer: "X",
        winner: "",
        mode: GameMode.vsPlayer,
      ),
    );
  }

  GameState copyWith({
    GameStateEntity? game,
    bool? isLoading,
  }) {
    return GameState(
      game: game ?? this.game,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [game, isLoading];
}

