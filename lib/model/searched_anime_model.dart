class SearchedAnimeModel {
  String cover;
  String name;
  String categories;
  String url;

  SearchedAnimeModel({this.cover, this.name, this.categories, this.url});

  SearchedAnimeModel.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    name = json['name'];
    categories = json['categories'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover'] = this.cover;
    data['name'] = this.name;
    data['categories'] = this.categories;
    data['url'] = this.url;
    return data;
  }
}
