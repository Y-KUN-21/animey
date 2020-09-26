import 'package:anime/model/anime_detail_model.dart';
import 'package:anime/model/popular.dart';
import 'package:anime/model/recent_dub.dart';
import 'package:anime/model/recent_sub.dart';
import 'package:anime/model/searched_anime_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'dart:convert';

class AnimeApiRequest {
  var _dioCacheManager = DioCacheManager(CacheConfig());
  Options _cacheOptions = buildCacheOptions(
    Duration(hours: 2),
    forceRefresh: false,
    maxStale: Duration(days: 1),
  );
  Dio dio = Dio();
  static String mainurl = "https://animeyapi.herokuapp.com";
  var getPopular = "$mainurl/popular";
  var getSubbed = "$mainurl/subbed";
  var getDubbed = "$mainurl/dubbed";
  var getDetail = "$mainurl/detail?anime=";
  var getSearched = "$mainurl/search/";
  var client = http.Client();
  Future<List<PopularAnimeModel>> getPopularAnime() async {
    dio.interceptors.add(_dioCacheManager.interceptor);
    Response response = await dio.get(getPopular, options: _cacheOptions);
    final List rawData = jsonDecode(jsonEncode(response.data).toString());
    if (response.statusCode != 200) {
      print("error");
    }
    List<PopularAnimeModel> popularAnimeModel =
        rawData.map((f) => PopularAnimeModel.fromJson(f)).toList();
    return popularAnimeModel;
  }

  Future<List<RecentSubbedModel>> getRecentSubbed() async {
    dio.interceptors.add(_dioCacheManager.interceptor);
    Response response = await dio.get(getSubbed, options: _cacheOptions);
    final List rawData = jsonDecode(jsonEncode(response.data));
    if (response.statusCode != 200) {
      print("error");
    }
    List<RecentSubbedModel> recentSubbedModel =
        rawData.map((f) => RecentSubbedModel.fromJson(f)).toList();
    return recentSubbedModel;
  }

  Future<List<RecentDubbedModel>> getRecentDubbed() async {
    dio.interceptors.add(_dioCacheManager.interceptor);
    print(getDubbed);
    Response response = await dio.get(getDubbed, options: _cacheOptions);
    final List rawData = jsonDecode(jsonEncode(response.data));
    if (response.statusCode != 200) {
      print("error");
    }
    List<RecentDubbedModel> recentDubbedModel =
        rawData.map((f) => RecentDubbedModel.fromJson(f)).toList();
    return recentDubbedModel;
  }

  Future<List<AnimeDetailModel>> getAnimeDetail(String anime) async {
    dio.interceptors.add(_dioCacheManager.interceptor);
    print(getDetail + anime);
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
}
