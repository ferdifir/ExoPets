import 'dart:io';

import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:exopets/model/transaction.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  List<Transaction> transaction = [];
  RxString selectedImage = ''.obs;
  RxString buktiUrl = ''.obs;

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

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      selectedImage.value = file.path;
      buktiUrl.value = await uploadPictureToStorage(file);
      update();
    } else {
      Get.snackbar('Error', 'Pilih file Gambar terlebih dahulu');
    }
  }

  Future<String> uploadPictureToStorage(File file) async {
    String fileName = file.path.split('/').last;
    Reference ref = _firebaseStorage.ref().child('transaction/$fileName');
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // ADD PAYMENT
  addPayment(int tid, String sender, String buktiUrl) async {
    try {
      final response = await _dio.post('/transactions/payment', data: {
        'transaction_id': tid,
        'sender_name': sender,
        'url_bukti': buktiUrl,
      });
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Bukti transfer berhasil diupload');
        getTransaction();
      } else {
        Get.snackbar('Error', 'Bukti transfer gagal diupload');
      }
    } catch (e) {
      print(e);
    }
  }
}
