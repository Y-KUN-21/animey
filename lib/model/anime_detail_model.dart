class AnimeDetailModel {
  String name;
  String description;
  String categories;
  String total;
  List<String> episodeNumber;
  List<String> episodes;

  AnimeDetailModel(
      {this.name,
      this.description,
      this.categories,
      this.total,
      this.episodeNumber,
      this.episodes});

  AnimeDetailModel.fromJson(Map<String, dynamic> json) {
    name = json['name '];
    description = json['description'];
    categories = json['categories'];
    total = json['total'];
    episodeNumber = json['episode_number'].cast<String>();
    episodes = json['episodes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name '] = this.name;
    data['description'] = this.description;
    data['categories'] = this.categories;
    data['total'] = this.total;
    data['episode_number'] = this.episodeNumber;
    data['episodes'] = this.episodes;
    return data;
  }
}
