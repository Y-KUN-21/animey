import 'package:anime/model/popanimemodel.dart';
import 'package:anime/res/anime_api_request.dart';
import 'package:get/get.dart';

class PopularController extends GetxController {
  var isLoading = true.obs;
  var popAnimemodel = List<PopAnimeModel>().obs;
  @override
  void onInit() {
    fetchPop();
    super.onInit();
  }

  void fetchPop() async {
    try {
      isLoading(true);
      var popanime = await AnimeApiRequest.getPopAnime();
      if (popanime != null) {
        popAnimemodel.value = popanime;
      }
    } finally {
      isLoading(false);
    }
  }
}
