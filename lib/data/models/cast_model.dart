class CastModel {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  CastModel({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
    id: json['id'],
    name: json['name'],
    character: json['character'] ?? "",
    profilePath: json['profile_path'] ?? "",
  );
}

class CrewModel {
  final int id;
  final String name;
  final String job;
  final String profilePath;

  CrewModel({
    required this.id,
    required this.name,
    required this.job,
    required this.profilePath,
  });

  factory CrewModel.fromJson(Map<String, dynamic> json) => CrewModel(
    id: json['id'],
    name: json['name'],
    job: json['job'] ?? "",
    profilePath: json['profile_path'] ?? "",
  );
}
