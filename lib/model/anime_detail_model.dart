class AnimeDetailModel {
  String name;
  String description;
  String studio;
  String tags;
  List<String> episodesNo;
  List<String> episodesLink;

  AnimeDetailModel(
      {this.name,
      this.description,
      this.studio,
      this.tags,
      this.episodesNo,
      this.episodesLink});

  AnimeDetailModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    studio = json['studio'];
    tags = json['tags'];
    episodesNo = json['episodes_no'].cast<String>();
    episodesLink = json['episodes_link'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['studio'] = this.studio;
    data['tags'] = this.tags;
    data['episodes_no'] = this.episodesNo;
    data['episodes_link'] = this.episodesLink;
    return data;
  }
}
