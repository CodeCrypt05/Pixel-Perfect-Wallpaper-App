class RandomWallpaper {
  String? artId;
  String? animename;
  String? arturl;
  int? sensitivity;

  RandomWallpaper({this.artId, this.animename, this.arturl, this.sensitivity});

  RandomWallpaper.fromJson(Map<String, dynamic> json) {
    artId = json['art_id'];
    animename = json['animename'];
    arturl = json['arturl'];
    sensitivity = json['sensitivity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['art_id'] = artId;
    data['animename'] = animename;
    data['arturl'] = arturl;
    data['sensitivity'] = sensitivity;
    return data;
  }
}
