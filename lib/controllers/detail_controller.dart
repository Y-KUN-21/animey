import 'package:anime/Database/DatabaseHelper.dart';
import 'package:anime/model/detailanimemodel.dart';
import 'package:anime/res/anime_api_request.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DetailController extends GetxController {
  final String anime;
  DatabaseHelper _databaseHelper;
  var isLoading = true.obs;
  var detailAnimeModel = List<DetailAnimeModel>().obs;

  DetailController(this.anime);
  @override
  void onInit() {
    _databaseHelper = DatabaseHelper.instance;
    fetchDetail(anime);
    super.onInit();
  }

  void fetchDetail(anime) async {
    try {
      if (anime != null) {
        isLoading(true);
        var detailAnime = await AnimeApiRequest.getDetailAnime(anime);
        if (detailAnime != null) {
          detailAnimeModel.value = detailAnime;
          update();
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void insertWatching(listdata, String url, String cover) async {
    try {
      Map<String, dynamic> row = {
        _databaseHelper.pkey: url.hashCode,
        _databaseHelper.name: listdata.name,
        _databaseHelper.status: listdata.status,
        _databaseHelper.season: listdata.season,
        _databaseHelper.imageUrl: cover,
        _databaseHelper.url: url
      };
      print(url.hashCode.toString());
      await _databaseHelper.insertWatching(row);
      Get.snackbar("Added", listdata.name);
    } on DatabaseException {
      Get.snackbar("Already Added", listdata.name);
      print(url.hashCode.toString());
    }
  }
}
