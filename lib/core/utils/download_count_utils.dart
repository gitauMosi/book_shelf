
String getBookDownloadCountText(int count) {
  if (count < 1000) {
    return count.toString();
  } else if (count < 1_000_000) {
    return '${(count / 1000).toStringAsFixed(1).replaceAll('.0', '')}k';
  } else {
    return '${(count / 1_000_000).toStringAsFixed(1).replaceAll('.0', '')}M';
  }
}