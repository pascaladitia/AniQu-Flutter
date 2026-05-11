import 'package:aniqu_flutter/core/error/failure.dart';
import 'package:aniqu_flutter/feature/home/data/models/anime/anime_item_model.dart';
import 'package:aniqu_flutter/feature/home/data/models/base_model.dart';
import 'package:dio/dio.dart';

class AnimeRemoteDataSource {
  final Dio dio;

  AnimeRemoteDataSource(this.dio);

  Failure _mapAPiFailure(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = e.response ?? 'Network error';
    return Failure('API: ${statusCode != null ? '[$statusCode]' : ''}$message');
  }

  Future<BaseModel<List<AnimeItemModel>>> getAnimeOngoing() async {
    try {
      final response = await dio.get('/ongoing');

      return BaseModel.fromJson(
          response.data, (json) => (json as List<dynamic>)
          .map((e) => AnimeItemModel.fromJson(e as Map<String, dynamic>)).toList()
      );
    } on DioException catch (e) {
      throw _mapAPiFailure(e);
    }
  }

  Future<BaseModel<List<AnimeItemModel>>> getAnimeCompleted() async {
    try {
      final response = await dio.get('/completed');

      return BaseModel.fromJson(
        response.data, (json) => (json as List<dynamic>)
          .map((e) => AnimeItemModel.fromJson(e as Map<String, dynamic>)).toList()
      );
    } on DioException catch (e) {
      throw _mapAPiFailure(e);
    }
  }
}