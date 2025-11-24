import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static const baseUrl = "https://api.themoviedb.org/3";
  static const imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  static final apiKey = dotenv.env['API_KEY'] ?? '';
}
