import 'package:dio/dio.dart';
import 'package:mymikano_app/models/StoreModels/AddressModel.dart';
import 'package:mymikano_app/models/StoreModels/ProductModel.dart';
import 'package:mymikano_app/services/DioClass.dart';
import 'package:mymikano_app/utils/appsettings.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerService {
  Dio dio = new Dio();
  Future<bool> addShippingAddress(
      String Address, String City, String State) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      Response response = await dio.post(
          MikanoShopAddShippingAddress.replaceAll(
              "{customerId}", prefs.getString("StoreCustomerId").toString()),
          options: Options(headers: {
            "Authorization": "Bearer ${prefs.getString("StoreToken")}"
          }),
          data: {
            "city": City,
            "address1": Address,
            "first_name": "f1",
            "last_name": "l1",
            "email": "email@hotmail.com",
            "country_id": 2,
            "state_province_id": 2,
            "zip_postal_code": "1001",
            "phone_number": "01234567",
          });
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to add shipping address');
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Address>> GetShippingAddressesForLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await dio.get(
      MikanoShopGetLoggedInUser,
      options: Options(headers: {
        "Authorization": "Bearer ${prefs.getString("StoreToken")}"
      }),
    );
    if (response.statusCode == 200) {
      List<Address> addresses = [];
      try {
        Address chosenAddress =
            Address.fromJson(response.data['customers'][0]['shipping_address']);
        var addressesdata = response.data['customers'][0]['addresses'];
        for (var item in addressesdata) {
          Address temp = Address.fromJson(item);
          if (chosenAddress.id != temp.id) {
            addresses.add(temp);
          } else {
            temp.chosen = true;
            addresses.add(temp);
          }
        }
        return addresses;
      } catch (e) {
        print(e);
        return addresses;
      }
    } else {
      throw Exception('Failed to get shipping addresses');
    }
  }

  Future<List<Product>> getAllFavoriteItemsforLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await dio.get(
      MikanoShopGetLoggedInUser,
      options: Options(headers: {
        "Authorization": "Bearer ${prefs.getString("StoreToken")}"
      }),
    );
    if (response.statusCode == 200) {
      List<Product> products = [];
      try {
        var productsdata = response.data['customers'][0]['FavoriteProducts'];
        for (var item in productsdata) {
          Product temp = Product.fromJson(item);
          products.add(temp);
        }
        return products;
      } catch (e) {
        print(e);
        return products;
      }
    } else {
      throw Exception('Failed to get shipping addresses');
    }
  }

  Future<bool> getTermsState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = await DioClass.getDio();
    Response response = await dio.get(
      MikanoShopGetTermsState.replaceAll(
          "{id}", prefs.getString("UserID").toString()),
      options: Options(
        headers: {"Authorization": "Bearer ${prefs.getString("accessToken")}"},
      ),
    );
    if (response.statusCode == 200) {
      try {
        return response.data;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      throw Exception('Failed to get shipping addresses');
    }
  }

  Future<bool> setTermsState(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = await DioClass.getDio();
    String url = MikanoShopSetTermsState.replaceAll(
        "{id}", prefs.getString("UserID").toString());
    Response response = await dio.put(
      url,
      queryParameters: {"termsAccepted": state},
      options: Options(
        headers: {"Authorization": "Bearer ${prefs.getString("accessToken")}"},
      ),
    );
    if (response.statusCode == 204) {
      try {
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      throw Exception('Failed to accept terms and services');
    }
  }

  Future<void> postContactUsRequest(
      String fullname, String email, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = await DioClass.getDio();
    String url = MikanoShopContactUs;
    try{
      Response response = await dio.post(url,
      options: Options(headers: {
        "Authorization": "Bearer ${prefs.getString("accessToken")}"
      }),
      data: {"fullName": fullname, "email": email, "message": message})
      ;
      if (response.statusCode == 201) {
        toast("Request sent successfully");
        return;
      } else {
        toast("Failed to send request");
        return;
      }
    }catch(e){
      toast("Failed to send request");
      return;
    }
  }
}
