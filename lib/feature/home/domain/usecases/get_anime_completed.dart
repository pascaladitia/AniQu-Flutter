import 'package:aniqu_flutter/core/error/result.dart';
import 'package:aniqu_flutter/feature/home/data/models/anime/anime_item_model.dart';
import 'package:aniqu_flutter/feature/home/domain/repositories/anime_repository.dart';

class GetAnimeCompleted {
  final AnimeRepository repository;

  GetAnimeCompleted(this.repository);

  Future<Result<List<AnimeItemModel>>> call() => repository.getAnimeCompleted();
}