import 'package:aniqu_flutter/feature/home/data/datasources/anime_remote_data_source.dart';
import 'package:aniqu_flutter/feature/home/data/repositories/anime_repository_impl.dart';
import 'package:aniqu_flutter/feature/home/domain/repositories/anime_repository.dart';
import 'package:aniqu_flutter/feature/home/domain/usecases/get_anime_completed_usecase.dart';
import 'package:aniqu_flutter/feature/home/domain/usecases/get_anime_ongoing_usecase.dart';
import 'package:aniqu_flutter/feature/home/presentation/home/home_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../feature/settings/presentation/cubit/settings_cubit.dart';
import '../network/anime_client.dart';
import '../storage/prefs_manager.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton(() => AnimeClient.create().dio);
  sl.registerLazySingleton(() => PrefsManager());
  sl.registerLazySingleton(() => SettingsCubit(sl()));

  sl.registerLazySingleton(() => AnimeRemoteDataSource(sl()));

  sl.registerLazySingleton<AnimeRepository>(
      () => AnimeRepositoryImpl(remote: sl())
  );

  sl.registerLazySingleton(() => GetAnimeOngoingUseCase(sl()));
  sl.registerLazySingleton(() => GetAnimeCompletedUseCase(sl()));

  sl.registerFactory(
      () => HomeCubit(animeOngoingUseCase: sl(), animeCompletedUseCase: sl())
  );
}