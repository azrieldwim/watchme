String formatRuntime(int? minutes) {
  if (minutes == null || minutes == 0) return '';
  final h = minutes ~/ 60;
  final m = minutes % 60;

  String result = '';
  if (h > 0) result += '${h}h ';
  if (m > 0) result += '${m}m';

  return result.trim();
}

const String localPlaceholderPath = 'assets/images/placeholder.png';

String getImageUrl(String? path, {required String baseUrl}) {
    if (path == null || path.isEmpty) {
        return localPlaceholderPath;
    }
    return '$baseUrl$path';
}