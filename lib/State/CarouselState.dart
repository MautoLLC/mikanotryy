import 'package:flutter/cupertino.dart';
import 'package:mymikano_app/models/CarouselImageModel.dart';
import 'package:mymikano_app/services/StoreServices/ProductService.dart';

class CarouselState extends ChangeNotifier {
  List<CarouselImageModel> topImages = [];
  List<CarouselImageModel> bottomImages = [];

  CarouselState() {
    update();
  }

  update() {
    fillImages();
  }

  void fillImages() async {
    List<CarouselImageModel> list = await ProductsService().getCarouselImages();
    for (var item in list) {
      item.position == "top" ? topImages.add(item) : bottomImages.add(item);
    }
    notifyListeners();
  }
}
