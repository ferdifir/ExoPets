import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:exopets/model/transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  final _auth = FirebaseAuth.instance;
  List<Transaction> transaction = [];

  @override
  void onInit() {
    super.onInit();
    getTransaction();
  }

  getTransaction() async {
    try {
      final User user = _auth.currentUser!;
      final response = await _dio.get('/transactions/transaction/${user.uid}');
      transaction = (response.data['data'] as List)
          .map((json) => Transaction.fromJson(json))
          .toList();
      update();
    } catch (e) {
      print(e);
    }
  }
}
