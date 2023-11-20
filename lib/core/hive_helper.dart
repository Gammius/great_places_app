import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static Future<Box<T>> getDB<T>(String nameBox) async{
    return await Hive.openBox<T>(nameBox);
  }

  static void closeDB(){
    Hive.close();
  }
}