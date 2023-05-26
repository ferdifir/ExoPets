String getTimeAgo(String dateTime) {
  final cta = DateTime.parse(dateTime);
  final now = DateTime.now();
  final difference = now.difference(cta);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} detik yang lalu';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} menit yang lalu';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} jam yang lalu';
  } else {
    return '${difference.inDays} hari yang lalu';
  }
}