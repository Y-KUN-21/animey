class SearchedAnimeModel {
  String name;
  String year;
  String season;
  String status;
  String imageurl;
  String url;

  SearchedAnimeModel(
      {this.name,
      this.year,
      this.season,
      this.status,
      this.imageurl,
      this.url});

  SearchedAnimeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    year = json['year'];
    season = json['season'];
    status = json['status'];
    imageurl = json['imageurl'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['year'] = this.year;
    data['season'] = this.season;
    data['status'] = this.status;
    data['imageurl'] = this.imageurl;
    data['url'] = this.url;
    return data;
  }
}
