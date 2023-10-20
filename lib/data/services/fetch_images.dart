import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:pixel_perfect_wallpaper_app/data/models/photos_model.dart';
import 'package:pixel_perfect_wallpaper_app/data/models/search_images_model.dart';

class FetchImage {
  String authorization = dotenv.env['AUTH_KEY']!;
  List<PhotosModel> photoList = [];
  List<SearchImagesModel> photoSearchList = [];
  final perPage = 80;

  //get random photos
  Future<List<PhotosModel>> getRandomPhotosAPI() async {
    final url =
        Uri.parse('https://api.pexels.com/v1/curated?per_page=$perPage&page=1');
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

// Tabs Category Images
  Future<List<SearchImagesModel>> getTabPhotosAPI(
      String query, int page) async {
    final url = Uri.parse(
        'https://api.pexels.com/v1/search?query=$query&per_page=$perPage&page=$page');
    final headers = {"Authorization": authorization};

    final response = await http.get(url, headers: headers);
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);

    if (response.statusCode == 200) {
      final searchPhotos = data['photos'];
      photoSearchList.clear();
      searchPhotos.forEach((element) {
        photoSearchList.add(SearchImagesModel.fromJson(element));
      });
      return photoSearchList;
    } else {
      return photoSearchList;
    }
  }

  // Search Images
  Future<List<SearchImagesModel>> getSearchPhotosAPI(String query) async {
    final url = Uri.parse(
        'https://api.pexels.com/v1/search?query=$query&per_page=80&page=1');
    final headers = {"Authorization": authorization};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final photos = data['photos'] as List<dynamic>;
      return photos.map((json) => SearchImagesModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
