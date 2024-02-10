// To parse this JSON data, do
//
//     final modelPost = modelPostFromJson(jsonString);

import 'dart:convert';

List<ModelPost> modelPostFromJson(String str) => List<ModelPost>.from(json.decode(str).map((x) => ModelPost.fromJson(x)));

class ModelPost {
  final int? id;
  final String? caption;
  final String? image;
  final DateTime? createdAt;

  ModelPost({required this.id, required this.caption, required this.image, required this.createdAt});
  factory ModelPost.fromJson(Map<String, dynamic> json) => ModelPost(
        id: json["id"] ?? 0,
        caption: json["caption"] ?? "",
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );
}
