import 'package:anime/model/anime_detail_model.dart';
import 'package:anime/model/searched_anime_model.dart';
import 'package:anime/res/anime_api_request.dart';

class ApiRepository {
  final String anime;
  final String search;

  ApiRepository({this.anime, this.search});
  AnimeApiRequest _provider = AnimeApiRequest();

  Future<List<AnimeDetailModel>> get getAnimeDetail =>
      _provider.getAnimeDetail(anime);
  Future<List<SearchedAnimeModel>> get getSearchedAnime =>
      _provider.getSearchedAnime(search);
}
