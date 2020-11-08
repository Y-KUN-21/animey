import 'package:anime/model/anime_detail_model.dart';
import 'package:anime/model/detailanimemodel.dart';
import 'package:anime/model/popanimemodel.dart';
import 'package:anime/model/recentanimemodel.dart';
import 'package:anime/model/searchanimemodel.dart';
import 'package:anime/model/searched_anime_model.dart';

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
  var client = http.Client();

  Future<List<AnimeDetailModel>> getAnimeDetail(String anime) async {
    dio.interceptors.add(_dioCacheManager.interceptor);

    Response response =
        await dio.get(getDetail + "$anime", options: _cacheOptions);
    final List rawData = jsonDecode(jsonEncode(response.data).toString());
    if (response.statusCode != 200) {
      print("error");
    }
    if (response.statusCode == 200) {
      List<AnimeDetailModel> animeDetailModel =
          rawData.map((f) => AnimeDetailModel.fromJson(f)).toList();
      return animeDetailModel;
    }
    return null;
  }

  Future<List<SearchedAnimeModel>> getSearchedAnime(String search) async {
    dio.interceptors.add(_dioCacheManager.interceptor);
    Response response =
        await dio.get(getSearched + "$search", options: _cacheOptions);
    final List rawData = jsonDecode(jsonEncode(response.data).toString());
    if (response.statusCode != 200) {
      print("error");
    }
    List<SearchedAnimeModel> searchedAnimeModel =
        rawData.map((f) => SearchedAnimeModel.fromJson(f)).toList();
    return searchedAnimeModel;
  }

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
