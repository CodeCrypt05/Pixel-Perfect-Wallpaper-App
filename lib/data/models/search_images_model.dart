class SearchImagesModel {
  final int id;
  final String src;

  SearchImagesModel({required this.id, required this.src});

  factory SearchImagesModel.fromJson(Map<String, dynamic> json) {
    return SearchImagesModel(
      id: json['id'],
      src: json['src']['portrait'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = id;
  //   data['src']['portrait'] = src;
  //   return data;
  // }
}
