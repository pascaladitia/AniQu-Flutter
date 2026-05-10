import 'package:aniqu_flutter/core/error/result.dart';
import 'package:aniqu_flutter/feature/home/data/models/anime/anime_item_model.dart';
import 'package:aniqu_flutter/feature/home/domain/repositories/anime_repository.dart';

class GetAnimeOngoing {
  final AnimeRepository repository;

  GetAnimeOngoing(this.repository);

  Future<Result<List<AnimeItemModel>>> call() => repository.getAnimeOngoing();
}