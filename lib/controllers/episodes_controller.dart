import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class EpisodeController extends GetxController {
  EpisodeController();
  @override
  void onInit() {
    super.onInit();
  }

  Future<String> fetchEpUrls(String episodeurl) async {
    try {
      String url = "https://animey.herokuapp.com/api/video?episode=$episodeurl";
      print(url);
      Response response = await Dio().get(url);
      if (response.statusCode != 200) {}
      final List rawData =
          await jsonDecode(jsonEncode(response.data).toString());
      var urls = await rawData[0];
      return urls['streamURL'] ?? urls['DownloadURL'];
    } finally {
      print("Success");
    }
  }
}
