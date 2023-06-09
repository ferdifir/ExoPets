import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:exopets/model/payment.dart';
import 'package:exopets/model/products.dart';
import 'package:exopets/model/userinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  List<Products> listProduct = [];
  List<UserProfile> listUser = [];
  List<Payment> listTransaction = [];
  List listReport = [];

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
      final response =
          await _dio.put('/admins/admin/${_auth.currentUser!.uid}/product/$id');
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
      final response = await _dio
          .delete('/admins/admin/${_auth.currentUser!.uid}/product/$id');
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
      final response =
          await _dio.get('/admins/admin/${_auth.currentUser!.uid}/user');
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
    listTransaction.clear();
    try {
      final id = _auth.currentUser!.uid;
      final response = await _dio.get('/admins/admin/$id/transaction');
      if (response.statusCode == 200) {
        printInfo(info: response.data['message']);
        final data = response.data['data'];
        data.forEach((element) {
          listTransaction.add(Payment.fromJson(element));
        });
        update();
      } else {
        printInfo(info: response.statusMessage!);
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
  }

  updateStatusTransaction(int id) async {
    try {
      final response = await _dio.post(
        '/transactions/transaction/update',
        data: {
          "transaction_id": id,
          "status": "Processing",
        },
      );
      if (response.statusCode == 200) {
        printInfo(info: response.data['message']);
        getTransactions();
      } else {
        printInfo(info: response.statusMessage!);
      }
    } catch (e) {
      printInfo(info: e.toString());
    }
  }

  getReport() async {
    listReport.clear();
    try {
      final response = await _dio.get('/users/report');
      if (response.statusCode == 200) {
        printInfo(info: response.data['message']);
        final data = response.data['data'];
        data.forEach((element) {
          listReport.add(element);
        });
        print(data);
        update();
      } else {
        printInfo(info: response.statusMessage!);
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
