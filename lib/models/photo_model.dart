import 'dart:convert';

class PhotoModel {
  final String id;
  final String title;
  final String urlImage;
  PhotoModel({
    required this.id,
    required this.title,
    required this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'urlImage': urlImage,
    };
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      urlImage: map['urlImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoModel.fromJson(String source) => PhotoModel.fromMap(json.decode(source));
}
