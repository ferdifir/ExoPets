import 'dart:io';

import 'package:exopets/common/config/config.dart';
import 'package:exopets/model/products.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:exopets/model/userinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  UserProfile? userProfile;
  bool isPasswordVisible = false;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString cityName = ''.obs;
  RxString selectedImage = ''.obs;
  RxString profilePicture = ''.obs;
  Map<String, dynamic> store = {};
  List<Products> products = [];

  @override
  void onInit() async {
    super.onInit();
    getLocation();
    getMyStore();
    getProducts();
    userProfile = await getUserInfo();
    update();
  }

  Future<String> uploadPictureToStorage(File file) async {
    String fileName = file.path.split('/').last;
    Reference ref = _firebaseStorage.ref().child('profile_picture/$fileName');
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  getMyStore() async {
    final uid = _auth.currentUser!.uid;
    try {
      final response = await _dio.get('/stores/store/$uid');
      if (response.statusCode == 200) {
        var result = response.data['data'];
        store = result;
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<String?> createMyStore(
    String name,
    String description,
    String address,
  ) async {
    final uid = _auth.currentUser!.uid;
    try {
      await _dio.post('/stores/create', data: {
        "uid": uid,
        "store_name": name,
        "address": address,
        "description": description,
      });
      return null;
    } catch (e) {
      printError(info: e.toString());
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
      profilePicture.value = await uploadPictureToStorage(file);
      update();
    } else {
      Get.snackbar('Error', 'Pilih file Gambar terlebih dahulu');
    }
  }

  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  Future<String?> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? profilePicture,
    double? latitude,
    double? longitude,
  }) async {
    User user = _auth.currentUser!;
    try {
      await user.updateEmail(email!);

      String profilePictureUrl = await uploadPictureToStorage(
        File(profilePicture!),
      );
      await _dio.put('/users/edit', data: {
        "uid": user.uid,
        "name": name,
        "email": email,
        "phone": phone,
        "lat": latitude,
        "lon": longitude,
        "profile_picture": profilePictureUrl,
      });
      return null;
    } catch (e) {
      printError(info: e.toString());
      return e.toString();
    }
  }

  Future<UserProfile?> getUserInfo() async {
    try {
      final response = await _dio.post('/users/login', data: {
        "uid": _auth.currentUser!.uid,
      });
      if (response.statusCode == 200) {
        var result = response.data['data'];
        var p = UserProfile.fromJson(result);
        printInfo(info: p.name);
        return p;
      }
    } catch (e) {
      printError(info: e.toString());
    }
    return null;
  }

  logout() async {
    await _auth.signOut();
  }

  void getLocation() async {
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
    getCityName();
    prefs.setDouble('latitude', position.latitude);
    prefs.setDouble('longitude', position.longitude);
  }

  getCityName() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude.value,
        longitude.value,
      );
      cityName.value = getLastWord(placemarks[0].subAdministrativeArea!);
    } catch (e) {
      printInfo(info: 'Error: $e');
    }
  }

  String getLastWord(String str) {
    List<String> words = str.split(' ');

    if (words.length == 1) {
      return str;
    }

    return words.last;
  }

  getProducts() async {
    String uid = _auth.currentUser!.uid;
    try {
      final response = await _dio.get('/products/product/$uid');
      if (response.statusCode == 200) {
        var result = response.data['data'];
        print(result);
        products = List<Products>.from(
          result.map((json) => Products.fromJson(json)),
        );
        printInfo(info: products.length.toString());
        update();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
