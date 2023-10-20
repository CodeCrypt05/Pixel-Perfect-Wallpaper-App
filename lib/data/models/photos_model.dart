class PhotosModel {
  String portrait;

  PhotosModel({required this.portrait});

  static fromJson(Map<String, dynamic> json) {
    return PhotosModel(portrait: (json['src'])['portrait']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['portrait'] = portrait;
    return data;
  }
}
