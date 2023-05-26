import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController {
  List wishlist = [];
  bool isWishlist = false;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    super.onInit();
    getWishlist();
  }

  getWishlist() async {
    final uid = _auth.currentUser!.uid;
    try {
      final response = await _dio.get('/wishlists/wishlist/$uid');
      if (response.statusCode == 200) {
        var result = response.data['data'];
        wishlist = result;
        update();
        printInfo(info: wishlist.toString());
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  addToWishlist(int id) async {
    try {
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final response = await _dio.post('/wishlists/wishlist', data: {
        'uid': uid,
        'pid': id,
      });
      if (response.statusCode == 200) {
        getWishlist();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  removeFromWishlist(int id) async {
    try {
      final User user = _auth.currentUser!;
      final String uid = user.uid;
      final response = await _dio.post('/wishlists/wishlist/delete', data: {
        'uid': uid,
        'pid': id,
      });
      if (response.statusCode == 200) {
        getWishlist();
      }
    } catch (e) {
      printError(info: e.toString());
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
