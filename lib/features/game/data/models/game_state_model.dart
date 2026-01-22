
import 'dart:convert';
import '../../../../core/utils/enums.dart';
import '../../domain/entities/game_state_entity.dart';

class GameStateModel extends GameStateEntity {
  const GameStateModel({
    required super.board,
    required super.currentPlayer,
    required super.winner,
    required super.mode,
  });

  factory GameStateModel.fromEntity(GameStateEntity e) {
    return GameStateModel(
      board: e.board,
      currentPlayer: e.currentPlayer,
      winner: e.winner,
      mode: e.mode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "board": board,
      "currentPlayer": currentPlayer,
      "winner": winner,
      "mode": mode.name,
    };
  }

  factory GameStateModel.fromMap(Map<String, dynamic> map) {
    return GameStateModel(
      board: List<String>.from(map["board"]),
      currentPlayer: map["currentPlayer"],
      winner: map["winner"],
      mode: GameMode.values.firstWhere((e) => e.name == map["mode"]),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory GameStateModel.fromJson(String json) {
    return GameStateModel.fromMap(jsonDecode(json));
  }
}