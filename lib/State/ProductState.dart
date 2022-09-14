import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mymikano_app/models/StoreModels/AddressModel.dart';
import 'package:mymikano_app/models/StoreModels/OrderModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductCartModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductCategory.dart';
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
  List<Order> ordersHistory = [];
  List<Product> trendingProducts = [];
  List<Product> topDealProducts = [];
  List<Product> featuredProducts = [];
  List<Product> allProducts = [];
  List<Product> ListOfProducts = [];
  int allProductNumbers = 0;
  int page = 0;
  List<String> filters = [];
  List<int> categoryFilters = [];
  int ItemsPerPage = 6;
  List<ProductCategory> allCategories = [];
  List<ProductCategory> mainCategories = [];
  List<ProductCategory> brandCategories = [];
  List<ProductCategory> AllFiltersForCategories = [];
  int selectedCategoryId = -1;
  int mainParentCategory = -1;
  String _searchTerm = '';
  List<Product> relatedProducts = [];

  void clear() {
    _searchTerm = '';
    relatedProducts.clear();
    selectMode = false;
    cashOnDelivery = true;
    productsInCart.clear();
    filters.clear();
    categoryFilters.clear();
    allCategories.clear();
    mainCategories.clear();
    brandCategories.clear();
    AllFiltersForCategories.clear();
    ordersHistory.clear();
    selectedProducts.clear();
    favoriteProducts.clear();
    purchasedProducts.clear();
    trendingProducts.clear();
    topDealProducts.clear();
    allProducts.clear();
    ListOfProducts.clear();
    allProductNumbers = 0;
    page = 0;
    notifyListeners();
  }

  ProductState() {
    update(isGuestLogin: true);
  }

  update({isGuestLogin = false}) async {
    if (!isGuestLogin) await getFavorites();
    await getAllProducts();
    for (var item in allProducts) {
      if (isInFavorite(item)) {
        item.liked = true;
      }
    }
    topDealProducts = [];
    await getTopDeals();
    await getFeatured();
    trendingProducts = [];
    for (var i = 0; i < 4; i++) {
      Random random = new Random();
      Product item = allProducts[random.nextInt(allProducts.length)];
      trendingProducts.add(item);
    }
    await fetchallCategories();
    await fetchBrandCategories();
    await fetchFilterCategories();

    allCategories.addAll(mainCategories);
    allCategories.addAll(brandCategories);
    allCategories.addAll(AllFiltersForCategories);
    final set = Set();
    allCategories.retainWhere((element) => set.add(element.id));

    if (!isGuestLogin) await updateCart();
    notifyListeners();
  }

  getRelatedProducts(int id) async {
    relatedProducts.clear();
    relatedProducts = await ProductsService().getRelatedProducts(id);
    notifyListeners();
  }

  setSearchTerm(String term) async {
    _searchTerm = term;
    page = 1;
    ListOfProducts.clear();
    await getListOfProducts(selectedCategoryId);
    notifyListeners();
  }

  String searchTerm() => _searchTerm;

  setselectedCategoryId(int id) {
    selectedCategoryId = id;
    notifyListeners();
  }

  addFilter(int filterID) {
    categoryFilters.add(filterID);
    notifyListeners();
  }

  removeFilter(int filterID) {
    categoryFilters.removeWhere((item) => item == filterID);
    notifyListeners();
  }

  bool checkIfFilterApplied(int filterID) {
    return categoryFilters.contains(filterID);
  }

  fetchBrandCategories() async {
    brandCategories.clear();
    for (ProductCategory item in mainCategories) {
      List<ProductCategory> tempResult =
          await ProductsService().getCategories(parentId: item.id!);
      brandCategories.addAll(tempResult);
    }
    final categories = Set();
    brandCategories.retainWhere((element) => categories.add(element.id));
    notifyListeners();
  }

  fetchFilterCategories() async {
    AllFiltersForCategories.clear();
    for (ProductCategory item in brandCategories) {
      List<ProductCategory> tempResult =
          await ProductsService().getCategories(parentId: item.id!);
      AllFiltersForCategories.addAll(tempResult);
    }
    final categories = Set();
    AllFiltersForCategories.retainWhere(
        (element) => categories.add(element.id));
    notifyListeners();
  }

  fetchallCategories() async {
    mainCategories = await ProductsService().getCategories(parentId: 42);
    notifyListeners();
  }

  fetchPurchases() async {
    ordersHistory = await CustomerService().getOrdersByCustomerID();
    notifyListeners();
  }

  sortByPriceLowToHigh() {
    ListOfProducts.sort(((a, b) => a.Price > b.Price ? 1 : -1));
    notifyListeners();
  }

  sortByPriceHighToLow() {
    ListOfProducts.sort(((a, b) => a.Price < b.Price ? 1 : -1));
    notifyListeners();
  }

  sortByPriceAToZ() {
    ListOfProducts.sort(
        ((a, b) => a.Name.toString().compareTo(b.Name.toString())));
    notifyListeners();
  }

  sortByPriceZToA() {
    ListOfProducts.sort(
        ((a, b) => b.Name.toString().compareTo(a.Name.toString())));
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

  Future<void> getProductsByCategory(int id) async {
    ListOfProducts = await ProductsService().getProducts(categoryID: id);
    notifyListeners();
  }

  Future<Product> fetchProductById(int id) async {
    List<Product> temp = await ProductsService().getProducts(ids: [id]);
    return temp.first;
  }

  Future<void> getTopDeals() async {
    topDealProducts = await ProductsService().getTopDealsProducts();
    notifyListeners();
  }

  Future<void> getFeatured() async {
    featuredProducts = await ProductsService().getFeaturedProducts();
    notifyListeners();
  }

  Future<void> updateCart() async {
    productsInCart = await CustomerService().getAllCartItemsforLoggedInUser();
    notifyListeners();
  }

  clearCart() {
    productsInCart.clear();
    selectedProducts.clear();
    // notifyListeners();
  }

  void Paginate([int categoryID = -1]) async {
    // !!Check for later
    // if (!(page + 1 > allProducts.length / ItemsPerPage)) {
    //   page++;
    //   await getListOfProducts(categoryID);
    // }
    page++;
    await getListOfProducts(categoryID);
    notifyListeners();
  }

  void clearListOfProducts() {
    ListOfProducts = [];
    page = 1;
    // notifyListeners();
  }

  Future<void> getListOfProducts([int categoryID = -1]) async {
    ListOfProducts.addAll(await ProductsService().getProducts(
        limit: ItemsPerPage,
        page: page,
        categoryID: categoryID,
        searchTerm: _searchTerm));
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
          item.product.liked = false;
          favoriteProducts.remove(item);
          await CustomerService().deleteFavoriteItemsforLoggedInUser([item.id]);
          break;
        }
      }
      try {
        topDealProducts
            .where((element) => element.id == product.id)
            .first
            .liked = false;
      } catch (e) {
        debugPrint(e.toString());
      }
      try {
        featuredProducts
            .where((element) => element.id == product.id)
            .first
            .liked = false;
      } catch (e) {
        debugPrint(e.toString());
      }
      try {
        trendingProducts
            .where((element) => element.id == product.id)
            .first
            .liked = false;
      } catch (e) {
        debugPrint(e.toString());
      }
      toast("Product removed from favorites");
    } else {
      FavoriteProduct t =
          await CustomerService().addFavoriteItemsforLoggedInUser(product);
      product.liked = true;
      favoriteProducts.add(t);
      toast("Product added to favorites");
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

  Future<void> addProduct(CartProduct product) async {
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
    productsInCart.clear();
    selectedProducts.clear();
    notifyListeners();
  }

  int get selectedProductsCount => selectedProducts.length;

  double get selectedProductsPrice => selectedProducts.fold(
      0, (total, product) => total + product.product.Price * product.quantity);

  Future<void> increaseCartItemQuantity(CartProduct product) async {
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

  Future<bool> checkout(Address add,
      {bool byCard = false, String reference = ""}) async {
    try {
      bool success = await CustomerService()
          .Checkout(add, selectedProducts, byCard, reference);
      if (success) {
        removecheckedProducts();
        update();
        toast("Checkout Successful");
        notifyListeners();
        return true;
      } else {
        toast("Checkout Failed");
        notifyListeners();
        return false;
      }
    } catch (e) {
      toast("Checkout Failed");
      debugPrint(e.toString());
      return false;
    }
  }
}
