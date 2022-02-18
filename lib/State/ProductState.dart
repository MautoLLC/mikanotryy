import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mymikano_app/models/StoreModels/AddressModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductCartModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductFavoriteModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/services/StoreServices/CustomerService.dart';
import 'package:mymikano_app/services/StoreServices/ProductService.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductState extends ChangeNotifier {
  bool selectMode = false;
  bool cashOnDelivery = true;
  List<CartProduct> productsInCart = [];
  List<CartProduct> selectedProducts = [];
  List<FavoriteProduct> favoriteProducts = [];
  List<Product> purchasedProducts = [];
  List<Product> trendingProducts = [];
  List<Product> popularProducts = [];
  List<Product> flashsaleProducts = [];
  List<Product> allProducts = [];
  List<Product> ListOfProducts = [];
  int allProductNumbers = 0;
  int page = 0;
  bool ListOfProductsLoaded = false;

  ProductState() {
    update();
  }

  void update() async {
    getFavorites();
    await getAllProducts();
    for (var item in allProducts) {
      if (isInFavorite(item)) {
        item.liked = true;
      }
    }
    purchasedProducts = [];
    for (var i = 0; i < 8; i++) {
      Random random = new Random();
      Product item = allProducts[random.nextInt(allProducts.length)];
      purchasedProducts.add(item);
    }
    trendingProducts = [];
    for (var i = 0; i < 4; i++) {
      Random random = new Random();
      Product item = allProducts[random.nextInt(allProducts.length)];
      trendingProducts.add(item);
    }
    popularProducts = [];
    for (var i = 0; i < 4; i++) {
      Random random = new Random();
      Product item = allProducts[random.nextInt(allProducts.length)];
      popularProducts.add(item);
    }
    flashsaleProducts = [];
    for (var i = 0; i < 3; i++) {
      Random random = new Random();
      Product item = allProducts[random.nextInt(allProducts.length)];
      flashsaleProducts.add(item);
    }
    await updateCart();
    notifyListeners();
  }

  Future<void> getFavorites() async {
    favoriteProducts =
        await CustomerService().getAllFavoriteItemsforLoggedInUser();
        notifyListeners();
  }

  Future<void> getAllProducts() async {
    allProducts = await ProductsService().getProducts();
    notifyListeners();
  }

  Future<void> updateCart() async {
    productsInCart = await CustomerService().getAllCartItemsforLoggedInUser();
    notifyListeners();
  }
  void toggleisLoading(){
    ListOfProductsLoaded = !ListOfProductsLoaded;
    notifyListeners();
  }
  void Paginate() async {
    page++;
    toggleisLoading();
    await getListOfProducts();  
    toggleisLoading();
    notifyListeners();
  }
  void clearListOfProducts(){
    ListOfProducts = [];
    notifyListeners();
  }
  Future<void> getListOfProducts() async {
    ListOfProducts.addAll(await ProductsService().getProducts(limit: 8, page: page));
    notifyListeners();
  }

  void setCashOnDelivery(bool value) {
    cashOnDelivery = value;
    notifyListeners();
  }

  bool get getCashOnDelivery => cashOnDelivery;

  int get getAllProductNumbers => allProductNumbers;

  void addorremoveProductToFavorite(Product product) async {
    if (isInFavorite(product)) {
      for (var item in favoriteProducts) {
        if (item.product.id == product.id) {
          product.liked = false;
          favoriteProducts.remove(item);
          await CustomerService()
              .deleteFavoriteItemsforLoggedInUser([item.product.id]);
          break;
        }
      }
      allProducts.firstWhere((element) => element.id == product.id).liked =
          false;
    } else {
      FavoriteProduct t =
          await CustomerService().addFavoriteItemsforLoggedInUser(product);
      allProducts.firstWhere((element) => element.id == product.id).liked =
          true;
      favoriteProducts.add(t);
    }
    notifyListeners();
  }

  bool isInFavorite(Product product) {
    for (var item in favoriteProducts) {
      if (item.product.id == product.id) {
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

  void removecheckedProducts() async {
    for (var item in selectedProducts) {
      productsInCart.remove(item);
    }
    notifyListeners();
  }

  int get selectedProductsCount => selectedProducts.length;

  double get selectedProductsPrice => selectedProducts.fold(
      0, (total, product) => total + product.product.Price * product.quantity);

  void increaseCartItemQuantity(CartProduct product) async {
    product.quantity++;
    await CustomerService()
        .ChangeQuantityCartProductforLoggedInUser(product, product.quantity);
    notifyListeners();
  }

  void decreaseCartItemQuantity(CartProduct product) async {
    if (product.quantity > 1) {
      product.quantity--;
      await CustomerService()
          .ChangeQuantityCartProductforLoggedInUser(product, product.quantity);
      notifyListeners();
    }
  }

  Future<bool> checkout(Address add, bool checkBox) async {
    if (!checkBox) {
      toast("Check the checkbox to agree to the terms of user");
    } else {
      bool success = await CustomerService().Checkout(add, selectedProducts);
      if (success) {
        List<int?> ids = selectedProducts.map((e) => e.product.id).toList();
        await CustomerService().deleteCartItemsforLoggedInUser(ids);
        removecheckedProducts();
        update();
        toast("Checkout Successful");
        return true;
      } else {
        toast("Checkout Failed");
      }
    }
    notifyListeners();
    return false;
  }
}
