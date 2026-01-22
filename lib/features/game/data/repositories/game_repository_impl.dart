import '../../domain/entities/game_state_entity.dart';
import '../../domain/repositories/game_repository.dart';
import '../datasources/game_local_datasource.dart';
import '../models/game_state_model.dart';

class GameRepositoryImpl implements GameRepository {
  final GameLocalDataSource local;

  GameRepositoryImpl(this.local);

  @override
  Future<GameStateEntity?> loadGame() async {
    return await local.loadGame();
  }

  @override
  Future<void> saveGame(GameStateEntity state) async {
    await local.saveGame(GameStateModel.fromEntity(state));
  }

  @override
  Future<void> resetGame() async {
    await local.resetGame();
  }
}