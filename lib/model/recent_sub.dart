class RecentSubbedModel {
  String name;
  String url;
  String cover;

  RecentSubbedModel({this.name, this.url, this.cover});

  RecentSubbedModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['cover'] = this.cover;
    return data;
  }
}
