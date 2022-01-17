import 'package:dio/dio.dart';
import 'package:mymikano_app/models/StoreModels/AddressModel.dart';
import 'package:mymikano_app/utils/appsettings.dart';
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
        Address chosenAddress = Address.fromJson(response.data['customers'][0]['shipping_address']);
        var addressesdata = response.data['customers'][0]['addresses'];
        for (var item in addressesdata) {
          Address temp = Address.fromJson(item);
          if(chosenAddress.id!=temp.id){
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

// Todo continue here to add the rest of the methods
  Future<void> SetChosenShippingAddress(Address address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await dio.post(
      MikanoShopGetLoggedInUser,
      options: Options(headers: {
        "Authorization": "Bearer ${prefs.getString("StoreToken")}"
      }),
      data: {
        "address_id": address.id,
      },
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to set chosen shipping address');
    }
  }
}
