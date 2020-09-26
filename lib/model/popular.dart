class PopularAnimeModel {
  String name;
  String url;
  String imageUrl;

  PopularAnimeModel({this.name, this.url, this.imageUrl});

  PopularAnimeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
