
import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums.dart';

class GameStateEntity extends Equatable {
  final List<String> board; // 9 cells
  final String currentPlayer; // "X" or "O"
  final String winner; // "", "X", "O", "Draw"
  final GameMode mode;

  const GameStateEntity({
    required this.board,
    required this.currentPlayer,
    required this.winner,
    required this.mode,
  });

  GameStateEntity copyWith({
    List<String>? board,
    String? currentPlayer,
    String? winner,
    GameMode? mode,
  }) {
    return GameStateEntity(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      winner: winner ?? this.winner,
      mode: mode ?? this.mode,
    );
  }

  @override
  List<Object?> get props => [board, currentPlayer, winner, mode];
}