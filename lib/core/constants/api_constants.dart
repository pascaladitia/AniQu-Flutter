import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static String get animeBaseUrl => dotenv.env['ANIME_BASE_URL'] ?? '';
  static String get mangaBaseUrl => dotenv.env['MANGA_BASE_URL'] ?? '';
}