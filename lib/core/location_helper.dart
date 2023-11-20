import 'dart:convert';

import 'package:http/http.dart' as http;
const GEOCODE_API = "YOUR_API_KEY";
const MAPS_API = "YOUR_API_KEY";

class LocationHelper{
   static String generateLocationPreviewImage({
    required double longitude,
    required double latitude,
  }) {

    return "https://static-maps.yandex.ru/v1?ll=$longitude,$latitude&size=450,450&z=13&pt=$longitude,$latitude,org&apikey=$MAPS_API";
  }

  static Future<String> getAddressFromLocation({
    required double longitude,
    required double latitude,
  }) async{
    String requestUrl = "https://geocode-maps.yandex.ru/1.x/?apikey=$GEOCODE_API&geocode=$longitude,$latitude&format=json";

    var response = await http.get(Uri.parse(requestUrl));

    String? result = jsonDecode(response.body)["response"]
    ["GeoObjectCollection"]["featureMember"][0]["GeoObject"]
    ["metaDataProperty"]["GeocoderMetaData"]["text"];

    return result ?? "";
  }
}