// To parse this JSON data, do
//
//     final popAnimeModel = popAnimeModelFromJson(jsonString);

import 'dart:convert';

List<PopAnimeModel> popAnimeModelFromJson(String str) =>
    List<PopAnimeModel>.from(
        json.decode(str).map((x) => PopAnimeModel.fromJson(x)));

String popAnimeModelToJson(List<PopAnimeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopAnimeModel {
  PopAnimeModel({
    this.name,
    this.url,
    this.cover,
  });

  String name;
  String url;
  String cover;

  factory PopAnimeModel.fromJson(Map<String, dynamic> json) => PopAnimeModel(
        name: json["name"],
        url: json["url"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "cover": cover,
      };
}
