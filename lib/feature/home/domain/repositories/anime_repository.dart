import 'package:aniqu_flutter/core/error/result.dart';
import 'package:aniqu_flutter/feature/home/data/models/anime/anime_item_model.dart';

abstract class AnimeRepository {
  Future<Result<List<AnimeItemModel>>> getAnimeOngoing();
  Future<Result<List<AnimeItemModel>>> getAnimeCompleted();
}