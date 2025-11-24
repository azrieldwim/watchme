class VideoModel {
  final String key;
  final String name;
  final String type;
  final String site;

  VideoModel({required this.key, required this.name, required this.type, required this.site});

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    key: json["key"],
    name: json["name"],
    type: json["type"],
    site: json["site"],
  );
}
