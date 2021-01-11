import 'package:anime/Database/DatabaseHelper.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class WatchingController extends GetxController {
  var watching = List<dynamic>().obs;
  DatabaseHelper _databaseHelper;
  @override
  void onInit() {
    _databaseHelper = DatabaseHelper.instance;
    fetchWatching();
    super.onInit();
  }

  Future fetchWatching() async {
    Database db = await _databaseHelper.db;
    var getWatching = await db.query(_databaseHelper.tableWatching);
    watching.value = getWatching;
    update();
  }
}
