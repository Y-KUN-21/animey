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
    this.tags,
    this.episodeNumber,
    this.episodeUrLs,
  });

  String name;
  String description;
  String tags;
  List<String> episodeNumber;
  List<String> episodeUrLs;

  factory DetailAnimeModel.fromJson(Map<String, dynamic> json) =>
      DetailAnimeModel(
        name: json["name"],
        description: json["description"],
        tags: json["tags"],
        episodeNumber: List<String>.from(json["episodeNumber"].map((x) => x)),
        episodeUrLs: List<String>.from(json["episodeURLs"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "tags": tags,
        "episodeNumber": List<dynamic>.from(episodeNumber.map((x) => x)),
        "episodeURLs": List<dynamic>.from(episodeUrLs.map((x) => x)),
      };
}
