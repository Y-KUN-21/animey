class RecentSubbedModel {
  String url;
  String cover;
  String name;

  RecentSubbedModel({this.url, this.cover, this.name});

  RecentSubbedModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    cover = json['cover'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['cover'] = this.cover;
    data['name'] = this.name;
    return data;
  }
}
