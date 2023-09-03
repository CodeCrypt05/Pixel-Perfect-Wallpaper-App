import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pixel_perfect_wallpaper_app/models/photos_model.dart';

String authorization = dotenv.env['AUTH_KEY']!;
List<PhotosModel> photoList = [];

Future<List<PhotosModel>> getRandomPhotosAPI() async {
  final url = Uri.parse('https://api.pexels.com/v1/curated?per_page=80&page=2');
  final headers = {"Authorization": authorization};

  final response = await http.get(url, headers: headers);
  Map<String, dynamic> data = jsonDecode(response.body);
  print(data);

  if (response.statusCode == 200) {
    List photos = data['photos'];
    photos.forEach((element) {
      photoList.add(PhotosModel.fromJson(element));
    });
    return photoList;
  } else {
    return photoList;
  }
}

// Tabs Category Images
Future<List<PhotosModel>> getTabPhotosAPI(String query) async {
  final url = Uri.parse(
      'https://api.pexels.com/v1/search?query=$query?per_page=80&page=1');
  final headers = {"Authorization": authorization};

  final response = await http.get(url, headers: headers);
  Map<String, dynamic> data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    List photos = data['photos'];
    photoList.clear();
    photos.forEach((element) {
      photoList.add(PhotosModel.fromJson(element));
    });
    return photoList;
  } else {
    return photoList;
  }
}
