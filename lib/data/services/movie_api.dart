class MovieApi {
  static const popular = "/movie/popular";
  static const topRated = "/movie/top_rated";
  static const upcoming = "/movie/upcoming";
  static const nowPlaying = "/movie/now_playing";
  static const search = "/search/movie";

  static String detail(int id) => "/movie/$id";
  static String credits(int id) => "/movie/$id/credits";
  static String videos(int id) => "/movie/$id/videos";
  static String releaseDates(int id) => "/movie/$id/release_dates";
}
