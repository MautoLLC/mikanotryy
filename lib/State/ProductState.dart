import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mymikano_app/models/StoreModels/ProductCartModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductFavoriteModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/services/StoreServices/CustomerService.dart';
import 'package:mymikano_app/services/StoreServices/ProductService.dart';

class ProductState extends ChangeNotifier {
  bool selectMode = false;
  List<CartProduct> productsInCart = [];
  List<CartProduct> selectedProducts = [];
  List<FavoriteProduct> favoriteProducts = [];
  List<Product> purchasedProducts = [];
  List<Product> trendingProducts = [];
  List<Product> popularProducts = [];
  List<Product> flashsaleProducts = [];
  List<Product> allProducts = [];
  int allProductNumbers = 0;

  ProductState() {
    update();
  }

  void update() async {
    allProducts = await ProductsService().getProducts();
    for (var i = 0; i < 8; i++) {
      Random random = new Random();
      Product item = allProducts[random.nextInt(allProducts.length)];
      purchasedProducts.add(item);
    }
    for (var i = 0; i < 4; i++) {
      Random random = new Random();
      Product item = allProducts[random.nextInt(allProducts.length)];
      trendingProducts.add(item);
    }
    for (var i = 0; i < 4; i++) {
      Random random = new Random();
      Product item = allProducts[random.nextInt(allProducts.length)];
      popularProducts.add(item);
    }
    for (var i = 0; i < 3; i++) {
      Random random = new Random();
      Product item = allProducts[random.nextInt(allProducts.length)];
      flashsaleProducts.add(item);
    }
    favoriteProducts = await CustomerService().getAllFavoriteItemsforLoggedInUser();
    productsInCart = await CustomerService().getAllCartItemsforLoggedInUser();
    notifyListeners();
  }

  int get getAllProductNumbers => allProductNumbers;


  void addorremoveProductToFavorite(Product product) async {
    if (isInFavorite(product)) {
      for (var item in favoriteProducts) {
        if(item.product.id == product.id){
          favoriteProducts.remove(product);
          await CustomerService().deleteFavoriteItemsforLoggedInUser([product.id]);
        }
      }
    } else {
      FavoriteProduct t = await CustomerService().addFavoriteItemsforLoggedInUser(product);
      favoriteProducts.add(t);
    }
    favoriteProducts = await CustomerService().getAllFavoriteItemsforLoggedInUser();
    notifyListeners();
  }

  bool isInFavorite(Product product) {
    for (var item in favoriteProducts) {
      if(item.product == product) {
        return true;
      }
    }
    return false;
  }

  int get totalFavoriteProducts => favoriteProducts.length;

  void toggleSelectMode() {
    selectMode = !selectMode;
    notifyListeners();
  }

  void addProduct(CartProduct product) async {
    product = await CustomerService().addCartItemsforLoggedInUser(product);
    productsInCart.add(product);
    notifyListeners();
  }

  void removeProduct(CartProduct product) async {
    await CustomerService().deleteCartItemsforLoggedInUser([product.id]);
    productsInCart.remove(product);
    notifyListeners();
  }

  void clearProducts() {
    productsInCart.clear();
    notifyListeners();
  }

  int get totalProducts => productsInCart.length;

  double get totalPrice =>
      productsInCart.fold(0, (total, product) => total + product.product.Price);

  void toggleProductSelection(CartProduct product) {
    if (selectMode) {
      if (selectedProducts.contains(product)) {
        selectedProducts.remove(product);
      } else {
        selectedProducts.add(product);
      }
      notifyListeners();
    }
  }

  void removeFromSelected(CartProduct product) {
    selectedProducts.remove(product);
    notifyListeners();
  }

  bool isProductSelected(CartProduct product) {
    if (selectMode) {
      return selectedProducts.contains(product);
    }
    return false;
  }

  void clearSelectedProducts() async {
    selectedProducts.clear();
    notifyListeners();
  }

  int get selectedProductsCount => selectedProducts.length;

  double get selectedProductsPrice =>
      selectedProducts.fold(0, (total, product) => total + product.product.Price);

  void increaseCartItemQuantity(CartProduct product) {
    product.quantity++;
    notifyListeners();
  }

  void decreaseCartItemQuantity(CartProduct product) {
    if (product.quantity > 1) {
      product.quantity--;
      notifyListeners();
    }
  }
}
