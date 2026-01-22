import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/enums.dart';
import '../cubit/game_cubit.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    context.read<GameCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.ticTacToe),
        actions: [
          IconButton(
            key: const Key("reset_btn"),
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<GameCubit>().reset(),
          ),
        ],
      ),
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          final game = state.game;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// Mode Selection
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<GameMode>(
                        value: game.mode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppStrings.gameMode,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: GameMode.vsPlayer,
                            child: Text(AppStrings.playerVsPlayer),
                          ),
                          DropdownMenuItem(
                            value: GameMode.vsComputer,
                            child: Text(AppStrings.playerVsComputer),
                          ),
                        ],
                        onChanged: (mode) async {
                          if (mode != null) {
                            await context.read<GameCubit>().reset();
                            context.read<GameCubit>().setMode(mode);
                          }
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Text(
                  game.winner.isEmpty
                      ? "Turn: ${game.currentPlayer}"
                      : (game.winner == "Draw"
                            ? "It's a Draw!"
                            : "Winner: ${game.winner}"),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                /// Board
                Expanded(
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => context.read<GameCubit>().makeMove(index),
                        child: Container(
                          key: Key("cell_$index"),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: Text(
                              game.board[index],
                              key: Key("cell_text_$index"),
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  AppStrings.autoSavedLocally,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
