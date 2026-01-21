
import 'package:get_it/get_it.dart';

import '../../features/game/data/datasources/game_local_datasource.dart';
import '../../features/game/data/repositories/game_repository_impl.dart';
import '../../features/game/domain/repositories/game_repository.dart';
import '../../features/game/domain/usecases/load_game.dart';
import '../../features/game/domain/usecases/reset_game.dart';
import '../../features/game/domain/usecases/save_game.dart';
import '../../features/game/presentation/cubit/game_cubit.dart';

final sl = GetIt.instance;

void initDependencies() {
  /// DataSource
  sl.registerLazySingleton(() => GameLocalDataSource());

  /// Repository
  sl.registerLazySingleton<GameRepository>(() => GameRepositoryImpl(sl()));

  /// Usecases
  sl.registerLazySingleton(() => LoadGame(sl()));
  sl.registerLazySingleton(() => SaveGame(sl()));
  sl.registerLazySingleton(() => ResetGame(sl()));

  /// Cubit
  sl.registerFactory(() => GameCubit(
      loadGame: sl(),
      saveGame: sl(),
      resetGame: sl(),
    ),
  );
}