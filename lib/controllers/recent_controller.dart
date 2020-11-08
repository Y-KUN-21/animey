import 'package:anime/model/recentanimemodel.dart';
import 'package:anime/res/anime_api_request.dart';
import 'package:get/get.dart';

class RecentController extends GetxController {
  var isLoading = true.obs;
  var recentAnimeModel = List<RecentAnimeModel>().obs;
  @override
  void onInit() {
    fetchRecent();
    super.onInit();
  }

  void fetchRecent() async {
    try {
      isLoading(true);
      var recentAnime = await AnimeApiRequest.getRecentAnime();
      if (recentAnime != null) {
        recentAnimeModel.value = recentAnime;
      }
    } finally {
      isLoading(false);
    }
  }
}
