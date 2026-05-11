import 'package:aniqu_flutter/core/error/failure.dart';
import 'package:aniqu_flutter/core/error/result.dart';
import 'package:aniqu_flutter/feature/home/data/datasources/anime_remote_data_source.dart';
import 'package:aniqu_flutter/feature/home/data/models/anime/anime_item_model.dart';
import 'package:aniqu_flutter/feature/home/domain/repositories/anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {

  final AnimeRemoteDataSource remote;

  AnimeRepositoryImpl({required this.remote});

  Future<Result<T>> _wrap<T>(Future<T> Function() fn) async {
    try {
      return Result.success(await fn());
    } on Failure catch (e) {
      return Result.error(e);
    } catch (_) {
      return const Result.error(Failure('Unexpected error occured'));
    }
  }

  @override
  Future<Result<List<AnimeItemModel>>> getAnimeOngoing() {
    return _wrap(() async {
      final response = await remote.getAnimeOngoing();
      return response.animes ?? [];
    });
  }

  @override
  Future<Result<List<AnimeItemModel>>> getAnimeCompleted() {
    return _wrap(() async {
      final response = await remote.getAnimeCompleted();
      return response.animes ?? [];
    });
  }

}