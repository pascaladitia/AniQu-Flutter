import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class AnimeClient {
  final Dio dio;

  AnimeClient._(this.dio);

  factory AnimeClient.create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.animeBaseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
      ),
    );

    return AnimeClient._(dio);
  }
}
