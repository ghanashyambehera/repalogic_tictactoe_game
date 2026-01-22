import '../entities/game_state_entity.dart';
import '../repositories/game_repository.dart';

class SaveGame {
  final GameRepository repo;
  SaveGame(this.repo);

  Future<void> call(GameStateEntity state) => repo.saveGame(state);
}