// To parse this JSON data, do
//
//     final detailAnimeModel = detailAnimeModelFromJson(jsonString);

import 'dart:convert';

List<DetailAnimeModel> detailAnimeModelFromJson(String str) =>
    List<DetailAnimeModel>.from(
        json.decode(str).map((x) => DetailAnimeModel.fromJson(x)));

String detailAnimeModelToJson(List<DetailAnimeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailAnimeModel {
  DetailAnimeModel({
    this.name,
    this.description,
    this.studio,
    this.tags,
    this.year,
    this.season,
    this.status,
    this.episodeNumber,
    this.episodes,
  });

  String name;
  String description;
  String studio;
  String tags;
  String year;
  String season;
  String status;
  List<String> episodeNumber;
  List<String> episodes;

  factory DetailAnimeModel.fromJson(Map<String, dynamic> json) =>
      DetailAnimeModel(
        name: json["name"],
        description: json["description"],
        studio: json["studio"],
        tags: json["tags"],
        year: json["year"],
        season: json["Season"],
        status: json["Status"],
        episodeNumber: List<String>.from(json["episodeNumber"].map((x) => x)),
        episodes: List<String>.from(json["episodes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "studio": studio,
        "tags": tags,
        "year": year,
        "Season": season,
        "Status": status,
        "episodeNumber": List<dynamic>.from(episodeNumber.map((x) => x)),
        "episodes": List<dynamic>.from(episodes.map((x) => x)),
      };
}
