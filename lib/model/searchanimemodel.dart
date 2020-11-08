// To parse this JSON data, do
//
//     final searchAnimeModel = searchAnimeModelFromJson(jsonString);

import 'dart:convert';

List<SearchAnimeModel> searchAnimeModelFromJson(String str) =>
    List<SearchAnimeModel>.from(
        json.decode(str).map((x) => SearchAnimeModel.fromJson(x)));

String searchAnimeModelToJson(List<SearchAnimeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchAnimeModel {
  SearchAnimeModel({
    this.name,
    this.year,
    this.season,
    this.status,
    this.cover,
    this.url,
  });

  String name;
  String year;
  String season;
  String status;
  String cover;
  String url;

  factory SearchAnimeModel.fromJson(Map<String, dynamic> json) =>
      SearchAnimeModel(
        name: json["name"],
        year: json["year"],
        season: json["season"],
        status: json["status"],
        cover: json["cover"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "year": year,
        "season": season,
        "status": status,
        "cover": cover,
        "url": url,
      };
}
