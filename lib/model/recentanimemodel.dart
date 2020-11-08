// To parse this JSON data, do
//
//     final recentAnimeModel = recentAnimeModelFromJson(jsonString);

import 'dart:convert';

List<RecentAnimeModel> recentAnimeModelFromJson(String str) =>
    List<RecentAnimeModel>.from(
        json.decode(str).map((x) => RecentAnimeModel.fromJson(x)));

String recentAnimeModelToJson(List<RecentAnimeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecentAnimeModel {
  RecentAnimeModel({
    this.name,
    this.url,
    this.cover,
  });

  String name;
  String url;
  String cover;

  factory RecentAnimeModel.fromJson(Map<String, dynamic> json) =>
      RecentAnimeModel(
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
