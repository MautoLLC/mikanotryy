import 'package:flutter/material.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/services/StoreServices/CustomerService.dart';
import 'package:mymikano_app/services/StoreServices/ProductService.dart';

class ProductState extends ChangeNotifier {
  bool selectMode = false;
  List<Product> productsInCart = [];
  List<Product> selectedProducts = [];
  List<Product> favoriteProducts = [];
  List<Product> allProducts = [];
  int allProductNumbers = 0;

  ProductState() {
    update();
  }

  void update() {
    ProductsService().getProducts().then((value) {
      allProducts = value;
      allProductNumbers = value.length;
      notifyListeners();
    });
    CustomerService().getAllFavoriteItemsforLoggedInUser().then((value) {
      favoriteProducts = value;
      notifyListeners();
    });
  }

  int getAllProductNumbers() {
    // updateAllProductNumbers();
    return allProductNumbers;
  }

  void addorremoveProductToFavorite(Product product) {
    if (favoriteProducts.contains(product)) {
      favoriteProducts.remove(product);
      ProductsService().removeProductToFavorite(product.id);
    } else {
      favoriteProducts.add(product);
      ProductsService().addProductToFavorite(product.id);
    }
    notifyListeners();
  }

  bool isInFavorite(Product product) {
    return favoriteProducts.contains(product);
  }

  int get totalFavoriteProducts => favoriteProducts.length;

  void toggleSelectMode() {
    selectMode = !selectMode;
    notifyListeners();
  }

  void addProduct(Product product) {
    productsInCart.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    productsInCart.remove(product);
    notifyListeners();
  }

  void clearProducts() {
    productsInCart.clear();
    notifyListeners();
  }

  int get totalProducts => productsInCart.length;

  double get totalPrice =>
      productsInCart.fold(0, (total, product) => total + product.Price);

  void toggleProductSelection(Product product) {
    if (selectMode) {
      if (selectedProducts.contains(product)) {
        selectedProducts.remove(product);
      } else {
        selectedProducts.add(product);
      }
      notifyListeners();
    }
  }

  void removeFromSelected(Product product) {
    selectedProducts.remove(product);
    notifyListeners();
  }

  bool isProductSelected(Product product) {
    if (selectMode) {
      return selectedProducts.contains(product);
    }
    return false;
  }

  void clearSelectedProducts() {
    selectedProducts.clear();
    notifyListeners();
  }

  int get selectedProductsCount => selectedProducts.length;

  double get selectedProductsPrice =>
      selectedProducts.fold(0, (total, product) => total + product.Price);
}
