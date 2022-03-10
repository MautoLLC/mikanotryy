class CarouselImageModel {
  int? id;
  String? url;
  String? position;

  CarouselImageModel({this.id, this.url, this.position});

  factory CarouselImageModel.fromJson(Map<String, dynamic> json) => CarouselImageModel(
    id: json["id"],
    url: json["url"],
    position: json["imageposition"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "imageposition": position,
  };
}
