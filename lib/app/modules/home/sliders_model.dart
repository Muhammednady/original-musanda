class Sliders {
  List<SliderData>? data;

  Sliders({this.data});

  Sliders.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SliderData>[];
      json['data'].forEach((v) {
        data?.add(SliderData.fromJson(v));
      });
    }
  }
}

class SliderData {
  late final int id;
  late final String image;

  SliderData({required this.id, required this.image});

  SliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
