import '../entities/game_state_entity.dart';

abstract class GameRepository {
  Future<GameStateEntity?> loadGame();
  Future<void> saveGame(GameStateEntity state);
  Future<void> resetGame();
}