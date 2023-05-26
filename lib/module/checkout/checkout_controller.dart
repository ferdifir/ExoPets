import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:exopets/model/address.dart';
import 'package:exopets/model/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  String selectedPaymentMethod = 'Cash on Delivery';
  String selectedShippingMethod = 'Standard Delivery';
  List<Cart> cart = [];
  List<Address> address = [];
  Address? selectedAddress;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCart();
    getAddress();
  }

  selectPaymentMethod(String method) {
    selectedPaymentMethod = method;
    update();
  }

  selectShippingMethod(String method) {
    selectedShippingMethod = method;
    update();
  }

  selectAddress(Address address) {
    selectedAddress = address;
    update();
  }

  addToTransaction(
    int productId,
    int quantity,
    int totalAmount,
  ) async {
    try {
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final response = await _dio.post('/transactions/transaction', data: {
        'uid': uid,
        'product_id': productId,
        'quantity': quantity,
        'total_amount': totalAmount,
        'status': selectedPaymentMethod == 'Cash on Delivery'
            ? 'Processing'
            : 'Awaiting Payment',
        'payment_method': selectedPaymentMethod,
        'shipping_address_id': selectedAddress!.id,
      });
      if (response.statusCode == 200) {
        for (var element in cart) {
          deleteFromCart(element.id);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      printInfo(info: 'Error: $e');
      return false;
    }
  }

  deleteAddress(int id) async {
    try {
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final response = await _dio.post('/addresses/address/delete', data: {
        'uid': uid,
        'aid': id,
      });
      if (response.statusCode == 200) {
        getAddress();
      }
    } catch (e) {
      printInfo(info: 'Error: $e');
    }
  }

  getAddress() async {
    address.clear();
    try {
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final response = await _dio.get('/addresses/address/$uid');
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        address = data.map((e) => Address.fromJson(e)).toList();
        update();
      } else {
        address = [];
        update();
      }
      printInfo(info: response.data);
    } catch (e) {
      printInfo(info: 'Error: $e');
    }
  }

  Future<bool> addAddress(
    String address,
    String city,
    String province,
    String postalCode,
  ) async {
    try {
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final response = await _dio.post('/addresses/address', data: {
        'uid': uid,
        'street_address': address,
        'city': city,
        'province': province,
        'postal_code': postalCode,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      printInfo(info: 'Error: $e');
      return false;
    }
  }

  locateMe() async {
    LocationPermission permission = await Geolocator.requestPermission();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (permission == LocationPermission.denied) {
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    prefs.setDouble('latitude', position.latitude);
    prefs.setDouble('longitude', position.longitude);
    setAddress();
  }

  setAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude.value,
        longitude.value,
      );
      addressController.value = TextEditingValue(
        text: placemarks[0].street!,
      );
      cityController.value = TextEditingValue(
        text: placemarks[0].subAdministrativeArea!,
      );
      provinceController.value = TextEditingValue(
        text: placemarks[0].administrativeArea!,
      );
      postalCodeController.value = TextEditingValue(
        text: placemarks[0].postalCode!,
      );
    } catch (e) {
      printInfo(info: 'Error: $e');
    }
  }

  getCart() async {
    cart.clear();
    try {
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final response = await _dio.get('/carts/cart/$uid');
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        cart = data.map((e) => Cart.fromJson(e)).toList();
        update();
      } else {
        cart = [];
        update();
      }
    } catch (e) {
      printInfo(info: 'Error: $e');
    }
  }

  Future<bool> deleteFromCart(int id) async {
    try {
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final response = await _dio.post('/carts/cart/delete', data: {
        'uid': uid,
        'pid': id,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      printInfo(info: 'Error: $e');
      return false;
    }
  }
}
