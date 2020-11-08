import 'package:anime/model/searchanimemodel.dart';
import 'package:anime/res/anime_api_request.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var anime;
  var isLoading = true.obs;
  var searchAnimeModel = List<SearchAnimeModel>().obs;
  @override
  void onInit() {
    fetchSearch(anime);
    super.onInit();
  }

  void fetchSearch(anime) async {
    try {
      if (anime != null) {
        isLoading(true);
        var searchAnime = await AnimeApiRequest.getSearchedAime(anime);
        if (searchAnime != null) {
          searchAnimeModel.value = searchAnime;
        }
      }
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
