import 'package:anime/model/detailanimemodel.dart';
import 'package:anime/model/popanimemodel.dart';
import 'package:anime/model/recentanimemodel.dart';
import 'package:anime/model/searchanimemodel.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'dart:convert';

class AnimeApiRequest {
  static var _dioCacheManager = DioCacheManager(CacheConfig());
  static Options _cacheOptions = buildCacheOptions(
    Duration(hours: 2),
    forceRefresh: false,
    maxStale: Duration(days: 1),
  );
  static Dio dio = Dio();
  static String mainurl = "https://animey.herokuapp.com/api";
  static var getPopular = "$mainurl/popular";
  static var getRecent = "$mainurl/recent";
  static var getDetail = "$mainurl/detail?anime=";
  static var getSearched = "$mainurl/search?anime=";
  static var getVideos = "$mainurl/video?episode=";
  var client = http.Client();

  static Future<List<PopAnimeModel>> getPopAnime() async {
    dio.interceptors.add(_dioCacheManager.interceptor);
    Response response = await dio.get(getPopular, options: _cacheOptions);
    if (response.statusCode == 200) {
      final String rawData = jsonEncode(response.data).toString();
      final popAnimeModel = popAnimeModelFromJson(rawData);
      return popAnimeModel;
    }
    return null;
  }

  static Future<List<RecentAnimeModel>> getRecentAnime() async {
    dio.interceptors.add(_dioCacheManager.interceptor);
    Response response = await dio.get(getRecent, options: _cacheOptions);
    if (response.statusCode == 200) {
      final String rawData = jsonEncode(response.data).toString();
      final recentAnimeModel = recentAnimeModelFromJson(rawData);
      return recentAnimeModel;
    }
    return null;
  }

  static Future<List<SearchAnimeModel>> getSearchedAime(String anime) async {
    dio.interceptors.add(_dioCacheManager.interceptor);
    Response response =
        await dio.get(getSearched + "$anime", options: _cacheOptions);
    if (response.statusCode == 200) {
      final String rawData = jsonEncode(response.data).toString();
      final searchAnimeModel = searchAnimeModelFromJson(rawData);
      return searchAnimeModel;
    }
    return null;
  }

  static Future<List<DetailAnimeModel>> getDetailAnime(String anime) async {
    dio.interceptors.add(_dioCacheManager.interceptor);
    Response response =
        await dio.get(getDetail + "$anime", options: _cacheOptions);
    if (response.statusCode == 200) {
      final String rawData = jsonEncode(response.data).toString();
      final detailAnimeModel = detailAnimeModelFromJson(rawData);
      return detailAnimeModel;
    }
    return null;
  }
}
