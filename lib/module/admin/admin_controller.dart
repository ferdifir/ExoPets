import 'dart:async';

import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:exopets/model/products.dart';
import 'package:exopets/model/transaction.dart';
import 'package:exopets/model/userinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  List<Products> listProduct = [];
  List<UserProfile> listUser = [];
  List<Transaction> listTransaction = [];

  @override
  onInit() {
    super.onInit();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      getListProduct();
    });
  }

  logout() async => await _auth.signOut();

  getListProduct() async {
    listProduct.clear();
    try {
      final response =
          await _dio.get('/admins/admin/${_auth.currentUser!.uid}/product');
      if (response.statusCode == 200) {
        final data = response.data['data'];
        data.forEach((element) {
          listProduct.add(Products.fromJson(element));
        });
        update();
      } else {
        printInfo(info: response.statusMessage!);
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
  }

  approveProduct(int id) async {
    try {
      final response = await _dio.put('/admins/admin/${_auth.currentUser!.uid}/product/$id');
      if (response.statusCode == 200) {
        printInfo(info: response.data['message']);
        getListProduct();
      } else {
        printInfo(info: response.statusMessage!);
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
  }

  deleteProduct(int id) async {
    try {
      final response = await _dio.delete('/admins/admin/${_auth.currentUser!.uid}/product/$id');
      if (response.statusCode == 200) {
        printInfo(info: response.data['message']);
        getListProduct();
      } else {
        printInfo(info: response.statusMessage!);
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
  }

  getAllUser() async {
    listUser.clear();
    try {
      final response = await _dio.get('/admins/admin/${_auth.currentUser!.uid}/user');
      if (response.statusCode == 200) {
        printInfo(info: response.data['message']);
        final data = response.data['data'];
        data.forEach((element) {
          listUser.add(UserProfile.fromJson(element));
        });
        update();
      } else {
        printInfo(info: response.statusMessage!);
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
  }

  deleteUser(String id) async {
    try {
      final response = await _dio.delete('/admins/admin/user/$id');
      if (response.statusCode == 200) {
        printInfo(info: response.data['message']);
        getAllUser();
      } else {
        printInfo(info: response.statusMessage!);
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
  }

  getTransactions() async {
    try {
      final response = await _dio.get('/admins/admin/${_auth.currentUser!.uid}/transaction');
      if (response.statusCode == 200) {
        printInfo(info: response.data['message']);
        final data = response.data['data'];
        data.forEach((element) {
          listTransaction.add(Transaction.fromJson(element));
        });
        update();
      } else {
        printInfo(info: response.statusMessage!);
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
  }
}
