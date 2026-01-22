
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_state_model.dart';

class GameLocalDataSource {
  static const _key = "tic_tac_toe_game";

  Future<GameStateModel?> loadGame() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return null;
    return GameStateModel.fromJson(json);
  }

  Future<void> saveGame(GameStateModel model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, model.toJson());
  }

  Future<void> resetGame() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}