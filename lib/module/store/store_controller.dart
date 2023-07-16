import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:exopets/model/products.dart';
import 'package:exopets/model/transaction.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  final uid = Get.arguments;
  int? sid;
  Map<String, dynamic> store = {};
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  RxString selectedImage = ''.obs;
  List<Products> products = [];
  List<Transaction> transaction = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    getMyStore().then((_) => getProducts());
    getTransaction();
  }

  setStore() async {
    nameController.text = store['nama_toko'];
    descriptionController.text = store['description'];
    addressController.text = store['alamat'];
    update();
  }

  getMyStore() async {
    store = {};
    try {
      final response = await _dio.get('/stores/store/$uid');
      if (response.statusCode == 200) {
        var result = response.data['data'];
        sid = result['sid'];
        printInfo(info: result.toString());
        store = result;
        update();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  updateStore() async {
    final uid = auth.currentUser!.uid;
    try {
      final response = await _dio.post('/stores/update', data: {
        'uid': uid,
        'store_name': nameController.text,
        'address': addressController.text,
        'description': descriptionController.text,
      });
      if (response.statusCode == 200) {
        printInfo(info: response.data.toString());
        getMyStore();
        Get.back();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  getProducts() async {
    String uid = auth.currentUser!.uid;
    try {
      final response = await _dio.get('/products/product/$uid/$sid/my');
      if (response.statusCode == 200) {
        var result = response.data['data'];
        if (kDebugMode) {
          print(sid);
          print(uid);
          print('result${response.data}');
        }
        products = List<Products>.from(
          result.map((json) => Products.fromJson(json)),
        );
        products = products.reversed.toList();
        printInfo(info: 'Produk:${products.length}');
        update();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  getTransaction() async {
    try {
      final User user = auth.currentUser!;
      final response = await _dio.get('/transactions/transaction/${user.uid}');
      transaction = (response.data['data'] as List)
          .map((json) => Transaction.fromJson(json))
          .toList();
      update();
      printInfo(info: transaction.length.toString());
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    Reference ref =
        FirebaseStorage.instance.ref().child('product_picture/$fileName');
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String?> uploadProduct({
    required String species,
    required String category,
    required String age,
    required String health,
    required String sex,
    required String price,
    required String description,
  }) async {
    try {
      final uid = auth.currentUser!.uid;
      final sid = store['sid'];
      final imageUrl = await uploadImage(File(selectedImage.value));
      final response = await _dio.post('/products/product/$uid', data: {
        'image': imageUrl,
        'product_name': species,
        'category': category,
        'age': int.parse(age),
        'health': health,
        'sex': sex,
        'price': int.parse(price),
        'details': description,
        'store_id': sid,
      });
      if (response.statusCode == 200) {
        printInfo(info: response.data.toString());
        getProducts();
        return null;
      } else {
        return response.data['message'];
      }
    } catch (e) {
      return e.toString();
    }
  }

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      selectedImage.value = file.path;
      update();
    } else {
      Get.snackbar('Error', 'Pilih file Gambar terlebih dahulu');
    }
  }
}
