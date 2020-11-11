import 'package:anime/Database/DatabaseHelper.dart';
import 'package:anime/model/detailanimemodel.dart';
import 'package:anime/res/anime_api_request.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      isLoading(true);
      if (anime != null) {
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
        _databaseHelper.imageUrl: cover,
        _databaseHelper.url: url
      };
      await _databaseHelper.insertWatching(row);
      Get.snackbar("Added", listdata.name,
          icon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.thumb_up_alt_outlined,
              size: 30,
            ),
          ),
          snackPosition: SnackPosition.BOTTOM,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          duration: Duration(seconds: 2));
    } on DatabaseException {
      Get.snackbar("Already Added", listdata.name,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          snackPosition: SnackPosition.BOTTOM,
          icon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              EvaIcons.alertCircle,
              size: 30,
            ),
          ),
          duration: Duration(seconds: 2));
    }
  }
}
