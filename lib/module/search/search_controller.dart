import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:exopets/model/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  RxList<Products> products = <Products>[].obs;

  searchPet(String query) async {
    try {
      final uid = _auth.currentUser!.uid;
      final response = await _dio.get('/products/product/$uid/search/$query');
      if (response.statusCode == 200) {
        products.value = response.data['data']
            .map<Products>((product) => Products.fromJson(product))
            .toList();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addTocart(int pid) async {
    try {
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final response = await _dio.post('/carts/cart', data: {
        'uid': uid,
        'pid': pid,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      printError(info: e.toString());
      return false;
    }
  }
}
