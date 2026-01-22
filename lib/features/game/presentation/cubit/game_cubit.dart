import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entities/game_state_entity.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/load_game.dart';
import '../../domain/usecases/reset_game.dart';
import '../../domain/usecases/save_game.dart';
part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final LoadGame loadGame;
  final SaveGame saveGame;
  final ResetGame resetGame;

  GameCubit({
    required this.loadGame,
    required this.saveGame,
    required this.resetGame,
  }) : super(GameState.initial());

  // Initialize the game state by loading saved data
  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    final saved = await loadGame();
    if (saved != null) {
      emit(state.copyWith(game: saved, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
  // Set the game mode
  void setMode(GameMode mode) {
    final newGame = state.game.copyWith(mode: mode);
    emit(state.copyWith(game: newGame));
    saveGame(newGame);
  }

  Future<void> reset() async {
    await resetGame();
    emit(GameState.initial());
  }
  // Make a move at the given index
  Future<void> makeMove(int index) async {
    final game = state.game;

    if (game.winner.isNotEmpty) return;
    if (game.board[index].isNotEmpty) return;
    // Update the board
    final updatedBoard = List<String>.from(game.board);
    // Set the current player's symbol at the chosen index
    updatedBoard[index] = game.currentPlayer;
    // Check for a winner
    final winner = _checkWinner(updatedBoard);
    // Switch players
    final nextPlayer = game.currentPlayer == "X" ? "O" : "X";
    // Create the updated game state
    var updatedGame = game.copyWith(
      board: updatedBoard,
      currentPlayer: winner.isEmpty ? nextPlayer : game.currentPlayer,
      winner: winner,
    );

    emit(state.copyWith(game: updatedGame));
    await saveGame(updatedGame);

    // If playing against computer and it's computer's turn, make a move
    if (updatedGame.mode == GameMode.vsComputer && updatedGame.winner.isEmpty && updatedGame.currentPlayer == "O") {
      await Future.delayed(const Duration(milliseconds: 400));
      await _computerMove();
    }
  }

  Future<void> _computerMove() async {
    final game = state.game;
    final emptyIndexes = <int>[];

    for (int i = 0; i < game.board.length; i++) {
      if (game.board[i].isEmpty) emptyIndexes.add(i);
    }

    if (emptyIndexes.isEmpty) return;
    // Pick a random empty index
    final randomIndex = emptyIndexes[Random().nextInt(emptyIndexes.length)];
    // Make the move
    await makeMove(randomIndex);
  }
  // Check for a winner or draw
  String _checkWinner(List<String> b) {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final line in lines) {
      final a = b[line[0]];
      final c = b[line[1]];
      final d = b[line[2]];

      if (a.isNotEmpty && a == c && a == d) {
        return a; // "X" or "O"
      }
    }

    if (!b.contains("")) return "Draw";
    return "";
  }
}