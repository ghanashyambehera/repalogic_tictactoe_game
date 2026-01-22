import '../repositories/game_repository.dart';

class ResetGame {
  final GameRepository repo;
  ResetGame(this.repo);

  Future<void> call() => repo.resetGame();
}