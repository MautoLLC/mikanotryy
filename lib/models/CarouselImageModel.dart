class CarouselImageModel {
  int? id;
  String? url;
  String? position;
  String? linkType;
  String? link;

  CarouselImageModel({this.id, this.url, this.position, this.link, this.linkType});

  factory CarouselImageModel.fromJson(Map<String, dynamic> json) =>
      CarouselImageModel(
        id: json["id"],
        url: json["url"],
        position: json["imageposition"],
        linkType: json["linkType"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "imageposition": position,
        "linkType": linkType,
        "link": link,
      };
}
