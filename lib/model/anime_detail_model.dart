class AnimeDetailModel {
  String name;
  String description;
  String studio;
  String tags;
  String year;
  String season;
  String status;
  List<String> episodeNumber;
  List<String> episodes;

  AnimeDetailModel(
      {this.name,
      this.description,
      this.studio,
      this.tags,
      this.year,
      this.season,
      this.status,
      this.episodeNumber,
      this.episodes});

  AnimeDetailModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    studio = json['studio'];
    tags = json['tags'];
    year = json['year'];
    season = json['Season'];
    status = json['Status'];
    episodeNumber = json['episodeNumber'].cast<String>();
    episodes = json['episodes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['studio'] = this.studio;
    data['tags'] = this.tags;
    data['year'] = this.year;
    data['Season'] = this.season;
    data['Status'] = this.status;
    data['episodeNumber'] = this.episodeNumber;
    data['episodes'] = this.episodes;
    return data;
  }
}
