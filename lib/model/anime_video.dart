class AnimeVideoModel {
  String url;
  String url2;
  String urlBackup;

  AnimeVideoModel({this.url, this.url2, this.urlBackup});

  AnimeVideoModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    url2 = json['url-2'];
    urlBackup = json['url-backup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['url_2'] = this.url2;
    data['url_backup'] = this.urlBackup;
    return data;
  }
}
