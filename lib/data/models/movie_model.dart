class MovieModel {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final double rating;
  final String releaseDate;
  final List<String>? genres;
  final int? runtime;
  final String? certification;

  const MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.rating,
    required this.releaseDate,
    this.genres,
    this.runtime,
    this.certification,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      title: json["title"] ?? "",
      posterPath: json["poster_path"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      overview: json["overview"] ?? "",
      rating: (json["vote_average"] ?? 0).toDouble(),
      releaseDate: json["release_date"] ?? "",
      genres:
          json["genres"] != null
              ? List<String>.from(json["genres"].map((x) => x["name"]))
              : null,
      runtime: json["runtime"],
      certification: null,
    );
  }

  MovieModel copyWith({
    List<String>? genres,
    int? runtime,
    String? certification,
  }) {
    return MovieModel(
      id: id,
      title: title,
      posterPath: posterPath,
      backdropPath: backdropPath,
      overview: overview,
      rating: rating,
      releaseDate: releaseDate,
      runtime: runtime ?? this.runtime,
      genres: genres ?? this.genres,
      certification: certification ?? this.certification,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "poster_path": posterPath,
      "backdrop_path": backdropPath,
      "overview": overview,
      "vote_average": rating,
      "release_date": releaseDate,
      "genres": genres,
      "runtime": runtime,
      "certification": certification,
    };
  }
}
