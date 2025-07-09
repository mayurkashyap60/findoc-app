class ImageModel {
  final String id;
  final String author;
  final String url;
  final String downloadUrl;
  final int width;
  final int height;

  ImageModel({
    required this.id,
    required this.author,
    required this.url,
    required this.downloadUrl,
    required this.width,
    required this.height,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      author: json['author'],
      url: json['url'],
      downloadUrl: json['download_url'],
      width: json['width'],
      height: json['height'],
    );
  }
}