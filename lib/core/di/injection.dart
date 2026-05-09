import 'package:get_it/get_it.dart';

import '../../feature/settings/presentation/cubit/settings_cubit.dart';
import '../network/anime_client.dart';
import '../storage/prefs_manager.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton(() => AnimeClient.create().dio);
  sl.registerLazySingleton(() => PrefsManager());
  sl.registerLazySingleton(() => SettingsCubit(sl()));
}