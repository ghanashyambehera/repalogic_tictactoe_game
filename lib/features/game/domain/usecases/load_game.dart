import '../entities/game_state_entity.dart';
import '../repositories/game_repository.dart';

class LoadGame {
  final GameRepository repo;
  LoadGame(this.repo);

  Future<GameStateEntity?> call() => repo.loadGame();
}